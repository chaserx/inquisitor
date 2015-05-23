require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  let(:valid_attributes) {
    {
      user_id: user.id, question_id: question.id,
      body: 'the money that you flaunt'
    }
  }

  let(:invalid_attributes) {
    { body: '', user: user.to_param }
  }

  context 'user is not signed in' do
    describe 'GET #index' do
      it 'redirects to a login_path' do
        get :index, user_id: user.to_param, question_id: question.to_param
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to a login_path' do
        get :show, user_id: user.to_param, question_id: question.to_param, id: 1
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'user is signed in' do
    let!(:answer) { create(:answer, user: user, question: question) }
    before do
      login_user user
    end

    describe 'GET #index' do
      it 'assigns all answers as @answers' do
        get :index, user_id: user.to_param, question_id: question.id
        expect(assigns(:answers)).to include(answer)
      end
    end

    describe 'GET #show' do
      it 'assigns the requested answer as @answer' do
        get :show, user_id: user.to_param, question_id: question.id, id: answer.to_param
        expect(assigns(:answer)).to eq(answer)
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested answer' do
        expect {
          delete :destroy, user_id: user.to_param, question_id: question.to_param,
                           id: answer.to_param
        }.to change(Answer, :count).by(-1)
      end

      it 'redirects to the questions list' do
        delete :destroy, user_id: user.to_param, question_id: question.to_param,
                         id: answer.to_param
        expect(response).to redirect_to(user_question_answers_url(user, question))
      end
    end
  end
end
