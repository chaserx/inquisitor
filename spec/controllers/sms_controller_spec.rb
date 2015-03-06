require 'rails_helper'

RSpec.describe SMSController, type: :controller do
  let(:mobile_phone) { create(:mobile_phone, :verified) }

  describe 'receive' do
    context 'when user sends start' do
      before do
        post :receive, 'From' => mobile_phone.number, 'Body' => 'start'
      end

      it 'returns TWIML XML with a Response node' do
        expect(response.body).to include('<Response>')
      end

      it 'contains enabled in the response body' do
        expect(response.body).to include('enabled')
      end

      it 'sets the mobile phone to enabled state' do
        expect(mobile_phone.reload.enabled?).to be(true)
      end
    end

    context 'when user sends stop' do
      before do
        post :receive, 'From' => mobile_phone.number, 'Body' => 'stop'
      end

      it 'returns TWIML XML with a Response node' do
        expect(response.body).to include('<Response>')
      end

      it 'contains disabled in the response body' do
        expect(response.body).to include('disabled')
      end

      it 'sets the mobile phone to disabled state' do
        expect(mobile_phone.reload.enabled?).to be(false)
      end
    end

    context 'when there is no such phone number' do
      it 'responds with unprocessable entitiy' do
        post :receive, 'From' => '+18598675309', 'Body' => 'start'
        expect(response.status).to be(422)
      end
    end

    context 'when the user sends a bad command' do
      before do
        post :receive, 'From' => mobile_phone.number, 'Body' => 'blarg'
      end

      it 'returns TWIML XML with a Response node' do
        expect(response.body).to include('<Response>')
      end

      it 'contains Unrecognized Command in the response body' do
        expect(response.body).to include('Unrecognized command')
      end
    end

    context 'when the user asks for help' do
      before do
        post :receive, 'From' => mobile_phone.number, 'Body' => 'help'
      end

      it 'returns TWIML XML with a Response node' do
        expect(response.body).to include('<Response>')
      end

      it 'contains help_url in the response body' do
        expect(response.body).to include("Visit http://localhost:3000/help to learn more.")
      end
    end
  end
end
