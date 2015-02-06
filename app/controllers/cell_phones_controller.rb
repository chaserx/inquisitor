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
      redirect_to cell_phone_path(@cell_phone)
    else
      flash[:warning] = 'Failed to save phone number.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  # POST /cell_phones/1/verify
  def verify
    if @cell_phone.auth_code.to_s == params[:verification_code].to_s
      @cell_phone.verified!
      flash[:notice] = 'Thanks! Your phone number is now verified.'
    else
      flash[:warning] = 'Invalid verification code.'
    end
    redirect_to edit_cell_phone_path(@cell_phone)
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
