require 'rails_helper.rb'

feature 'destroy post' do
  background do
      post = create(:post, caption: 'delete me')
      visit '/'
      find(:xpath, "//a[contains(@href,'posts/1')]").click
      click_link 'Edit Post'
  end
  scenario 'able to delete post' do
    click_link 'Delete Post'
    expect(page).to have_content('Post deleted.')
    expect(page).not_to have_content('delete me')
  end
end
