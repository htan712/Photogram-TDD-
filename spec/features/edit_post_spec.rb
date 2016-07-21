require 'rails_helper.rb'

feature 'editing post' do
  background do
    post = create(:post)
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
  end
  scenario 'edit and update post' do
    fill_in 'Caption', with: "Oh god, you weren’t meant to see this picture!"
    click_button 'Update Post'
    expect(page).to have_content("Post updated.")
    expect(page).to have_content("Oh god, you weren’t meant to see this picture!")
  end
  scenario 'unable to edit/update without image' do
    attach_file('Image', "spec/files/notimage.zip")
    click_button 'Update Post'
    expect(page).to have_content("Error updating.")
  end
end
