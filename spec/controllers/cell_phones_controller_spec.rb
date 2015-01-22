require 'rails_helper'

RSpec.describe CellPhonesController, type: :controller do
  describe 'POST create' do
    before { post :create, number: '8595551212' }

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'redirects to show' do
      expect(response).to redirect_to(cell_phone_path(assigns(:cell_phone)))
    end
  end
end
