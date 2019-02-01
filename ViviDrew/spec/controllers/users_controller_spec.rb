require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'should render the create user page' do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'GET #show' do
    it 'should render the user\'s profile page' do
      get :show, params: {id: User.last.id}
      expect(response).to render_template(:show)
    end
  end
  
  describe 'POST #create' do

    context 'with valid params' do
      before(:each) do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
      end

      it 'should log in the user' do
        expect(session[:session_token]).to eq(User.last.session_token)
      end

      it 'should redirect to the user\'s show page' do
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context 'with invalid params' do
      it 'should render the create user page' do
        post :create, params: { user: {username: 'cheese'} }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end


  end
end
