require 'rails_helper.rb'

feature 'Creating a new user' do
  background do
    visit '/'
    click_link 'Register'
    fill_in 'Email', with: 'hock@gmail.com'
    fill_in 'Password', with: 'helloworld', match: :first
    fill_in 'Password confirmation', with: 'helloworld'
  end
  scenario 'can create a new user via the index page' do
    fill_in 'User name', with: 'hock'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario 'require a user name to sign up' do
    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
  end
  scenario 'user name must have atleast 4 characters' do
    fill_in 'User name', with: 'z'
    click_button 'Sign up'
    expect(page).to have_content('minimum is 4 characters')
  end
  scenario 'user name cannot have more than 16 characters' do
    fill_in 'User name', with: 'zzzzzzzzzzzzzzzzzzz'
    click_button 'Sign up'
    expect(page).to have_content('maximum is 16 characters')
  end
end
