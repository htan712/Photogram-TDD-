require 'rails_helper.rb'

feature 'destroy post' do
  background do
    user = create(:user)
    post = create(:post, caption: 'delete me', user: user)
    sign_in_with user
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
  end
  scenario 'able to delete post' do
    click_link 'Delete Post'
    expect(page).to have_content('Post deleted.')
    expect(page).to_not have_content('delete me')
  end
end
