require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'a new answer' do
    it 'fails validation with no body' do
      expect(subject).to have(1).errors_on(:body)
    end
  end
end
