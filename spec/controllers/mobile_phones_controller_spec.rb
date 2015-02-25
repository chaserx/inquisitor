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

    describe 'PUT update' do
      let(:mobile_phone) { create(:mobile_phone, user: user) }

      let(:new_attributes) {
        { number: '+18595552424' }
      }

      it 'updates the requested mobile phone' do
        put :update, user_id: user.id, id: mobile_phone.to_param,
                     mobile_phone: new_attributes
        expect(mobile_phone.reload.number).to eq(new_attributes[:number])
      end
    end

    describe 'POST verify' do
      let(:mobile_phone) { create(:mobile_phone, user: user) }

      context 'with a valid verification_code' do
        it 'verfies the mobile phone' do
          post :verify, user_id: user.id, id: mobile_phone.to_param,
                        verification_code: mobile_phone.auth_code
          expect(mobile_phone.reload.verified?).to eq(true)
        end
      end

      context 'with an invalid verification_code' do
        it 'fails to verfy the mobile phone' do
          post :verify, user_id: user.id, id: mobile_phone.to_param,
                        verification_code: '0'
          expect(mobile_phone.reload.verified?).to eq(false)
        end
      end
    end
  end
end
