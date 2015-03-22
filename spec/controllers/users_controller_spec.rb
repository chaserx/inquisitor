require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
    { email: 'clipper@' }
  }

  context 'when a user is not signed in' do
    let(:user) { create(:user) }

    describe 'GET index' do
      it 'redirects the user to sign in' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET show' do
      it 'redirects the user to sign in' do
        get :show, id: user.to_param
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET new' do
      it 'assigns a new user as @user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new User' do
          expect {
            post :create, user: valid_attributes
          }.to change(User, :count).by(1)
        end

        it 'assigns a newly created user as @user' do
          post :create, user: valid_attributes
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it 'redirects to the created user' do
          post :create, user: valid_attributes
          expect(response).to redirect_to(User.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved user as @user' do
          pending 'WTF'
          post :create, user: invalid_attributes
          expect(assigns(:user)).to be_a_new(User)
        end

        it 're-renders the new template' do
          pending 'WTF'
          post :create, user: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end
  end

  context 'when a user is signed in' do
    let(:user) { create(:user) }

    before do
      login_user user
    end

    describe 'GET index' do
      it 'assigns all users as @users' do
        get :index
        expect(assigns(:users)).to eq([user])
      end
    end

    describe 'GET show' do
      it 'assigns the requested user as @user' do
        get :show, id: user.to_param
        expect(assigns(:user)).to eq(user)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested user as @user' do
        get :edit, id: user.to_param
        expect(assigns(:user)).to eq(user)
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        let(:new_attributes) {
          { email: Faker::Internet.free_email('chase') }
        }

        it 'updates the requested user' do
          put :update, id: user.to_param, user: new_attributes
          expect(user.reload.email).to eq(new_attributes[:email])
        end

        it 'assigns the requested user as @user' do
          put :update, id: user.to_param, user: new_attributes
          expect(assigns(:user)).to eq(user)
        end

        it 'redirects to the user' do
          put :update, id: user.to_param, user: new_attributes
          expect(response).to redirect_to(user)
        end
      end

      describe 'with invalid params' do
        it 'assigns the user as @user' do
          put :update, id: user.to_param, user: invalid_attributes
          expect(assigns(:user)).to eq(user)
        end

        it 're-renders the edit template' do
          put :update, id: user.to_param, user: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested user' do
        expect {
          delete :destroy, id: user.to_param
        }.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        delete :destroy, id: user.to_param
        expect(response).to redirect_to(users_url)
      end
    end
  end
end
