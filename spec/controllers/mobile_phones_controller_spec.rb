require 'rails_helper'

RSpec.describe MobilePhonesController, type: :controller do
  context 'when a user is not signed in' do
    describe 'POST create' do
      let(:make_request) {
        post :create, user_id: 1, mobile_phone: attributes_for(:mobile_phone)
      }

      it 'does not create a new mobile phone' do
        expect{make_request}.not_to change(MobilePhone, :count)
      end

      it 'redirects to login path' do
        make_request
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'when a user is signed in' do
    let(:user) { create(:user) }

    before do
      login_user user
    end

    describe 'POST create' do
      let(:make_request) {
        post :create, user_id: user, mobile_phone: attributes_for(:mobile_phone)
      }

      it 'responds successfully' do
        make_request
        expect(assigns(:mobile_phone)).to be_a(MobilePhone)
        expect(assigns(:mobile_phone)).to be_persisted
      end

      it 'redirects to show' do
        make_request
        expect(response).to redirect_to(user_mobile_phone_path(user,
                                                               assigns(:mobile_phone)))
        expect(response).to be_redirect
      end
    end
  end
end
