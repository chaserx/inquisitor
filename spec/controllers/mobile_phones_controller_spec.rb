require 'rails_helper'

RSpec.describe MobilePhonesController, type: :controller do
  describe 'POST create' do
    let(:make_request) {
      post :create, mobile_phone: attributes_for(:mobile_phone)
    }

    it 'responds successfully' do
      make_request
      expect(assigns(:mobile_phone)).to be_a(MobilePhone)
      expect(assigns(:mobile_phone)).to be_persisted
    end

    it 'redirects to show' do
      make_request
      expect(response).to redirect_to(mobile_phone_path(assigns(:mobile_phone)))
    end
  end
end
