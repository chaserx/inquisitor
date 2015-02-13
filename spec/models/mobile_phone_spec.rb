require 'rails_helper'

RSpec.describe MobilePhone, type: :model do
  it 'requires a number' do
    expect(subject).to have(2).errors_on(:number)
  end

  it 'requires a number to be formatted a particular way' do
    subject.number = '859-867-5309'
    expect(subject).to have(1).error_on(:number)
  end

  describe 'generate_auth_code' do
    it 'generates a 5-digit number' do
      expect(CellPhone.generate_auth_code.to_s).to match(/\d{5}/)
    end
  end

  context 'a verified cell phone number' do
    subject { create(:cell_phone, :verified) }

    it 'can be reset' do
      subject.reset_verification!
      expect(subject.reload.verified?).to be(false)
    end
  end
end
