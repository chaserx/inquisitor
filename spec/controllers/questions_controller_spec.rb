require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) {
    { body: 'So Whatcha Want?' }
  }

  let(:invalid_attributes) {
    { body: '', user: user.to_param }
  }

  context 'user not signed in' do
    describe 'GET #index' do
      it 'redirects to a login_path' do
        get :index, user_id: user.to_param, id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to a login_path' do
        get :show, user_id: user.to_param, id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to a login_path' do
        post :create, user_id: user.to_param, question: valid_attributes
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'user is signed in' do
    let(:question) { create(:question, user: user) }
    before do
      login_user user
    end

    describe 'GET #index' do
      it 'assigns all questions as @questions' do
        get :index, user_id: user.to_param
        expect(assigns(:questions)).to eq([question])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested question as @question' do
        get :show, user_id: user.to_param, id: question.to_param
        expect(assigns(:question)).to eq(question)
      end
    end

    describe 'GET #new' do
      it 'assigns a new question as @question' do
        get :new, user_id: user.to_param
        expect(assigns(:question)).to be_a_new(Question)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested question as @question' do
        get :edit, user_id: user.to_param, id: question.to_param
        expect(assigns(:question)).to eq(question)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Question' do
          expect {
            post :create, user_id: user.to_param, question: valid_attributes
          }.to change(Question, :count).by(1)
        end

        it 'assigns a newly created question as @question' do
          post :create, user_id: user.to_param, question: valid_attributes
          expect(assigns(:question)).to be_a(Question)
          expect(assigns(:question)).to be_persisted
        end

        it 'redirects to the created question' do
          post :create, user_id: user.to_param, question: valid_attributes
          expect(response).to redirect_to([user, Question.last])
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved question as @question' do
          post :create, user_id: user.to_param, question: invalid_attributes
          expect(assigns(:question)).to be_a_new(Question)
        end

        it "re-renders the 'new' template" do
          post :create, user_id: user.to_param, question: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          {body: 'Whatcha doing?'}
        }

        it 'updates the requested question' do
          put :update, user_id: user.to_param, id: question.to_param,
                       question: new_attributes
          expect(question.reload).to eq(question)
        end

        it 'assigns the requested question as @question' do
          put :update, user_id: user.to_param, id: question.to_param,
                       question: valid_attributes
          expect(assigns(:question)).to eq(question)
        end

        it 'redirects to the question' do
          put :update, user_id: user.to_param, id: question.to_param,
                       question: valid_attributes
          expect(response).to redirect_to([user, question])
        end
      end

      context 'with invalid params' do
        it 'assigns the question as @question' do
          put :update, user_id: user.to_param, id: question.to_param,
                       question: invalid_attributes
          expect(assigns(:question)).to eq(question)
        end

        it "re-renders the 'edit' template" do
          put :update, user_id: user.to_param, id: question.to_param,
                       question: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested question' do
        expect {
          delete :destroy, user_id: user.to_param, id: question.to_param
        }.to change(Question, :count).by(-1)
      end

      it 'redirects to the questions list' do
        delete :destroy, user_id: user.to_param, id: question.to_param
        expect(response).to redirect_to(user_questions_url(user))
      end
    end
  end
end
