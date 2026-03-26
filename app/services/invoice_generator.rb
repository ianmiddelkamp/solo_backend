class InvoiceGenerator
  def initialize(client:, start_date: nil, end_date: nil)
    @client     = client
    @start_date = start_date
    @end_date   = end_date
    @tax_rate   = BusinessProfile.instance.tax_rate || 0
  end

  def generate!
    time_entries = unbilled_entries
    return nil if time_entries.empty?

    ActiveRecord::Base.transaction do
      invoice = Invoice.create!(
        client: @client,
        status: "pending",
        start_date: @start_date,
        end_date: @end_date
      )

      time_entries.each do |entry|
        rate = effective_rate(entry)
        InvoiceLineItem.create!(
          invoice: invoice,
          time_entry: entry,
          description: build_description(entry),
          hours: entry.hours,
          rate: rate,
          amount: entry.hours * rate,
          tax_rate: @tax_rate
        )
      end

      items    = invoice.invoice_line_items.reload
      subtotal = items.sum(:amount)
      tax      = items.sum { |i| i.amount * i.tax_rate / 100 }
      invoice.update!(total: subtotal + tax)
      invoice
    end
  end

  private

  def unbilled_entries
    scope = TimeEntry.joins(:project)
                     .left_outer_joins(:invoice_line_item)
                     .where(projects: { client_id: @client.id })
                     .where(invoice_line_items: { id: nil })
                     .includes(:task, project: :rates)

    scope = scope.where("date >= ?", @start_date) if @start_date.present?
    scope = scope.where("date <= ?", @end_date) if @end_date.present?
    scope
  end

  def build_description(entry)
    parts = [entry.description.presence, entry.task&.title.presence].compact
    parts.join(" · ")
  end

  def effective_rate(entry)
    entry.project.rates.first&.rate ||
      entry.project.client.rates.first&.rate ||
      0
  end
end
