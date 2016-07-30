require 'rails_helper.rb'

feature 'Index of posts' do
  background do
    user = create(:user)
    job_one = create(:post, caption: "This is post one", user: user)
    job_two = create(:post, caption: "This is post two", user: user)
    sign_in_with user
  end
  scenario 'display all posts' do
    visit '/'
    expect(page).to have_content("This is post one")
    expect(page).to have_content("This is post two")
    expect(page).to have_css("img[src*= 'coffee.jpg']")
  end
end
