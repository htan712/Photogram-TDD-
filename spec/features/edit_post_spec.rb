require 'rails_helper.rb'

feature 'editing post' do
  background do
    user = create(:user)
    user_two = create(:user, email: 'natalee@gmail.com',
                             user_name: 'natalee',
                             id: user.id + 1)
    post = create(:post, user: user)
    post_two = create(:post, user: user_two)
    sign_in_with user
    visit '/'
  end
  scenario 'can edit and update post belongs to user' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('Edit Post')

    click_link 'Edit Post'
    fill_in 'Caption', with: "Oh god, you weren’t meant to see this picture!"
    click_button 'Update Post'

    expect(page).to have_content("Post updated.")
    expect(page).to have_content("Oh god, you weren’t meant to see this picture!")
  end

  scenario "cannot edit and update post that doesn't belong to user" do
    find(:xpath, "//a[contains(@href,'posts/2')]").click
    expect(page).to_not have_content('Edit Post')
  end

  scenario "cannot edit/update post that doesn't belong to user via url path" do
    visit "/posts/2/edit"
    expect(page.current_path).to eq root_path
    expect(page).to have_content("That post doesn't belong to you!")
  end

  scenario 'unable to edit/update without image' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
    attach_file('Image', "spec/files/notimage.zip")
    click_button 'Update Post'
    expect(page).to have_content("Error updating.")
  end
end
