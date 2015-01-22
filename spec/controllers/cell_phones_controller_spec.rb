require 'rails_helper'

RSpec.describe CellPhonesController, type: :controller do
  describe 'POST create' do
    let(:make_request) {
      post :create, cell_phone: attributes_for(:cell_phone)
    }

    it 'responds successfully' do
      make_request
      expect(assigns(:cell_phone)).to be_a(CellPhone)
      expect(assigns(:cell_phone)).to be_persisted
    end

    it 'redirects to show' do
      make_request
      expect(response).to redirect_to(cell_phone_path(assigns(:cell_phone)))
    end
  end
end
