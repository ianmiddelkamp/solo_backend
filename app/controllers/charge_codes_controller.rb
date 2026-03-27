class ChargeCodesController < ApplicationController
  before_action :set_charge_code, only: [:update, :destroy]

  def index
    render json: ChargeCode.all.order(:code)
  end

  def create
    @charge_code = ChargeCode.new(charge_code_params)
    if @charge_code.save
      render json: @charge_code, status: :created
    else
      render json: { errors: @charge_code.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @charge_code.update(charge_code_params)
      render json: @charge_code
    else
      render json: { errors: @charge_code.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @charge_code.destroy
    head :no_content
  end

  private

  def set_charge_code
    @charge_code = ChargeCode.find(params[:id])
  end

  def charge_code_params
    params.require(:charge_code).permit(:user_id, :code, :description, :rate)
  end
end
