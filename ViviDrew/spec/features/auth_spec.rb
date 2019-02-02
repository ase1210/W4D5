require 'spec_helper'
require 'rails_helper'

RSpec.feature "Auths", type: :feature do
  # subject(:user) { FactoryBot.build(:user) }
  
  feature 'the signup process' do
    scenario 'has a new user page' do
      visit new_user_path
      expect(page).to have_content('Sign Up')
    end
    
    feature 'signing up a user' do
      
      scenario 'shows username on the user\'s profile page after signup' do
        visit new_user_path
        # save_and_open_page
        fill_in 'Username', with: 'vividrew'
        fill_in 'Password', with: 'vividrew'
        click_button 'Sign Up'
        expect(current_path).to eq(user_path(User.last))
        expect(page).to have_content(User.last.username)
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
end