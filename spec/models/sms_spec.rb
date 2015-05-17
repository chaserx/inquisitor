require 'rails_helper'

RSpec.describe SMS, type: :model do
  describe 'a new SMS' do
    it 'fails validation with no mobile phone' do
      expect(subject).to have(1).errors_on(:mobile_phone)
    end
  end

  describe '#decipher_command with start message' do
    pending "not there yet"
  end

  describe '#decipher_command with stop message' do
    pending "not there yet"
  end

  describe '#decipher_command with help message' do
    pending "not there yet"
  end

  describe '#decipher_command with an unrecognized message' do
    pending "not there yet"
  end
end
