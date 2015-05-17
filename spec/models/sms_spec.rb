require 'rails_helper'

RSpec.describe SMS, type: :model do
  describe 'a new SMS' do
    it 'fails validation with no mobile phone' do
      expect(subject).to have(1).errors_on(:mobile_phone)
    end
  end
end
