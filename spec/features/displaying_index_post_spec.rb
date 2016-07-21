require 'rails_helper.rb'

feature 'Index of posts' do
  scenario 'display all posts' do
    job_one = create(:post, caption: "This is post one")
    job_two = create(:post, caption: "This is post two")

    visit '/'
    expect(page).to have_content("This is post one")
    expect(page).to have_content("This is post two")
    expect(page).to have_css("img[src*= 'coffee.jpg']")
  end
end
