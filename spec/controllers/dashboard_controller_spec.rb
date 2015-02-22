require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  context 'when a user is not signed in' do
    describe 'GET index' do
      it 'returns http redirect' do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context 'when a user is signed in' do
    let(:user) { create(:user) }

    before do
      login_user user
    end

    describe 'GET index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
