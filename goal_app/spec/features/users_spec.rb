require 'spec_helper'
require 'rails_helper'


feature 'signup page' do
    
    scenario 'has a new user page' do
        visit new_user_url
        
        expect(page).to have_content 'New User'
    end
        feature 'signing up a user' do
            let!(:user) {build(:user)}    
            scenario 'shows username on the homepage after signup' do
                create_user(user)
                visit users_url
                save_and_open_page
                expect(page).to have_content "#{user.username}"
            end
        end    
end

feature 'logging in' do
    scenario 'shows username on the homepage after login'

end

feature 'logging out' do
    scenario 'begins with a logged out state'

    scenario 'doesn\'t show username on the homepage after logout'

end