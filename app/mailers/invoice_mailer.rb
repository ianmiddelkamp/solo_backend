class InvoiceMailer < ApplicationMailer
  def invoice_email(invoice)
    @invoice  = invoice
    @client   = invoice.client
    @business = BusinessProfile.instance

    attachments["#{@invoice.number}.pdf"] = {
      mime_type: "application/pdf",
      content: @invoice.pdf.download
    }

    if @business.logo.attached?
      attachments.inline["logo"] = {
        data:      @business.logo.download,
        mime_type: @business.logo.content_type
      }
    end

    mail(
      to:      @client.email1,
      subject: "Invoice #{invoice.number} from #{@business.name.presence || 'us'}"
    )
  end
end
