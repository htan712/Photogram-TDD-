require 'rails_helper.rb'

feature 'User authentication' do
  background do
    user = create(:user)
    sign_in_with user
  end

  scenario 'can log in from the index via nav bar log in' do
    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')
  end

  scenario 'user can log out' do
    expect(page).to have_content('Signed in successfully.')
    click_link 'Logout'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
feature 'user not signed in' do
  background do
    user = create(:user)
  end

  scenario 'cannot view index posts without loggin in' do
    visit '/'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'cannot create post without logging in' do
    visit '/posts/new'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
