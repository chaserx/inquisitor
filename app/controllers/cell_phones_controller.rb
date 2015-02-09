class CellPhonesController < ApplicationController
  before_action :set_cell_phone, except: [:new, :create]

  # GET /cell_phones/new
  def new
    @cell_phone = CellPhone.new
  end

  # POST /cell_phones
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

  # GET /cell_phones/1
  def show
  end

  # GET /cell_phones/1/edit
  def edit
  end

  # PUT /cell_phones/1
  def update
    if @cell_phone.update(cell_phone_params)
      flash[:notice] = 'Your phone has been updated.'
    else
      flash[:warning] = 'We could not update your phone.'
    end
    redirect_to cell_phone_path(@cell_phone)
  end

  # DELETE /cell_phones/1
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
    redirect_to cell_phone_path(@cell_phone)
  end

  # POST /cell_phones/1/reset
  def reset
    if @cell_phone.reset!
      flash[:notice] = 'We\'re resetting your authorization code.'
    else
      flash[:warning] = 'We could not reset your authorization code.'
    end
    redirect_to cell_phone_path(@cell_phone)
  end

  private

  def cell_phone_params
    params.require(:cell_phone).permit(:number)
  end

  def set_cell_phone
    @cell_phone = CellPhone.find(params[:id])
  end
end
