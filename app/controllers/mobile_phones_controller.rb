class MobilePhonesController < ApplicationController
  before_action :set_mobile_phone, except: [:new, :create]

  # GET /mobile_phones/new
  def new
    @mobile_phone = MobilePhone.new
  end

  # POST /mobile_phones
  def create
    @mobile_phone = MobilePhone.new(mobile_phone_params)
    if @mobile_phone.save
      flash[:notice] = 'Saved! We will send you a code to ' +
                       'verify your number.'
      redirect_to mobile_phone_path(@mobile_phone)
    else
      flash[:warning] = 'Failed to save phone number.'
      render :new
    end
  end

  # GET /mobile_phones/1
  def show
  end

  # GET /mobile_phones/1/edit
  def edit
  end

  # PUT /mobile_phones/1
  def update
    if @mobile_phone.update(mobile_phone_params)
      flash[:notice] = 'Your phone has been updated.'
    else
      flash[:warning] = 'We could not update your phone.'
    end
    redirect_to mobile_phone_path(@mobile_phone)
  end

  # DELETE /mobile_phones/1
  def destroy
  end

  # POST /mobile_phones/1/verify
  def verify
    if @mobile_phone.auth_code.to_s == params[:verification_code].to_s
      @mobile_phone.verified!
      flash[:notice] = 'Thanks! Your phone number is now verified.'
    else
      flash[:warning] = 'Invalid verification code.'
    end
    redirect_to mobile_phone_path(@mobile_phone)
  end

  # POST /mobile_phones/1/reset
  def reset
    if @mobile_phone.reset!
      flash[:notice] = 'We\'re resetting your authorization code.'
    else
      flash[:warning] = 'We could not reset your authorization code.'
    end
    redirect_to mobile_phone_path(@mobile_phone)
  end

  private

  def mobile_phone_params
    params.require(:mobile_phone).permit(:number).merge(user: current_user)
  end

  def set_mobile_phone
    @mobile_phone = MobilePhone.find(params[:id])
  end
end
