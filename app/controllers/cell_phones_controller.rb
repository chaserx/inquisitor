class CellPhonesController < ApplicationController
  before_action :set_cell_phone, except: [:new, :create, :validate]

  def new
    @cell_phone = CellPhone.new
  end

  def create
    @cell_phone = CellPhone.new(cell_phone_params)
    if @cell_phone.save
      flash[:notice] = 'Saved! We will send you a code to ' +
                       'verify your number.'
    else
      flash[:warning] = 'Failed to save phone number.'
    end
    redirect_to cell_phone_path(@cell_phone)
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
