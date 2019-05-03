require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'GET #index' do
        it 'renders users index' do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe 'GET #new' do
        it 'renders new users form' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'GET #show' do
        let!(:user) { create(:user) }
        context 'renders show users' do
            it 'with valid params' do
                get :show, params: { id: user.id }
                expect(response).to render_template(:show)
            end

            it 'with invalid params' do
                get :show, params: { id: '' }
                expect(response).to redirect_to(users_url)
            end
        end
    end

    describe 'GET #edit' do
        let!(:user) { create(:user) }
        context 'renders edit user form' do
            it 'with valid params' do
                get :edit, params: { id: user.id }
                expect(response).to render_template(:edit)
            end

            it 'with invalid params' do
                get :edit, params: { id: '' }
                expect(response).to redirect_to(users_url)
            end
        end
    end


    describe 'POST #create' do
        
        context 'with valid params' do
            let!(:valid_params) {{user:{username: "muk", password: "digimon"}}}
            it 'creates user' do
                post :create, params: valid_params
                expect(User.last.username).to eq("muk")
            end
        end

        context 'with invalid params' do
            let!(:invalid_params){{user:{nothing: ""}}}
            it 'does not create user' do
                post :create, params: invalid_params
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'PATCH #update' do
        let!(:user) {create(:user)}
        context 'with valid params' do
            let!(:valid_params) {{user:{username: "muk", password: "digimon"}, id: user.id}}
            it 'updates user' do
                patch :update, params: valid_params
                expect(User.last.username).to eq("muk")
            end
        end

        context 'with invalid params' do
            let!(:invalid_params){{user:{password: "1"}, id: user.id}}
            it 'does not update user' do
                patch :update, params: invalid_params
                expect(response).to render_template(:edit)
            end
        end
    end

    describe 'DELETE #destroy' do
        let!(:user) {create(:user)}
        before(:each) do
            delete :destroy, params: {id: user.id}
        end
        it 'deletes user' do
            expect(User.exists?(user.id)).to be(false)
        end
    end

end