class CellPhonesController < ApplicationController
  before_action :set_cell_phone, except: [:new, :create, :validate]

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def verify
  end

  def reset
  end

  private

  def cell_phone_params
    params.require(:cell_phone).permit(:number)
  end

  def set_cell_phone
    @cell_phone = CellPhone.find(params[:id])
  end
end
