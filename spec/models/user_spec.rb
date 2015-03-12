require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'a new user' do
    context 'with validation errors' do
      it 'has an error on email' do
        expect(subject).to have(1).error_on(:email)
      end

      it 'has an error on time zone' do
        expect(subject).to have(1).error_on(:time_zone)
      end
    end

    context 'with valid data' do
      subject { create(:user) }

      describe 'new user gravatar setting' do
        it 'sets the gravatar_url' do
          expect(subject.gravatar_url).to be
        end
      end

      describe 'new user questions' do
        it 'creates stock questions' do
          expect(subject.questions.count).to be > 1
        end
      end
    end
  end
end
