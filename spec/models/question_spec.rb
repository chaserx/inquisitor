require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'a new question' do
    it 'fails validation with no body' do
      puts subject.errors.inspect
      expect(subject).to have(2).errors_on(:body)
    end

    it 'fails validation with no user' do
      expect(subject).to have(1).errors_on(:user_id)
    end
  end

  describe 'an existing question awaiting an answer' do
    pending 'not there yet'
  end

  describe 'an existing answered question' do
    pending 'not there yet'
  end
end
