class TimeEntriesController < ApplicationController
  before_action :set_project, if: -> { params[:project_id].present? }
  before_action :set_time_entry, only: [:show, :update, :destroy]

  def index
    entries = if @project
      @project.time_entries
    else
      scope = TimeEntry.all
      scope = scope.where(charge_code_id: params[:charge_code_id]) if params[:charge_code_id].present?
      scope = scope.where(project_id: nil) if params[:charge_code_id].present? || params[:charge_codes_only].present?
      scope
    end

    render json: entries
      .includes(:task, :project, :charge_code, invoice_line_item: :invoice)
      .order(date: :desc)
      .as_json(
        include: {
          task: { only: %i[id title] },
          project: { only: %i[id name] },
          charge_code: { only: %i[id code description] },
          invoice_line_item: { include: { invoice: { methods: :number } } }
        }
      )
  end

  def show
    render json: @time_entry.as_json(
      include: {
        task: { only: %i[id title] },
        project: { only: %i[id name] },
        charge_code: { only: %i[id code description] }
      }
    )
  end

  def create
    @time_entry = if @project
      @project.time_entries.new(time_entry_params)
    else
      TimeEntry.new(time_entry_params)
    end

    if @time_entry.save
      render json: @time_entry, status: :created
    else
      render json: { errors: @time_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @time_entry.update(time_entry_params)
      render json: @time_entry
    else
      render json: { errors: @time_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @time_entry.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_entry
    @time_entry = @project ? @project.time_entries.find(params[:id]) : TimeEntry.find(params[:id])
  end

  def time_entry_params
    params.require(:time_entry).permit(
      :user_id, :date, :hours, :description,
      :started_at, :stopped_at,
      :task_id, :project_id, :charge_code_id, :client_id
    )
  end
end
