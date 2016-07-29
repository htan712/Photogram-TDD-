require 'rails_helper.rb'

feature 'Creating posts' do
  background 'create User' do
    user = create(:user)
    sign_in_with user
  end
  scenario 'can create a post' do
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('hocktan')
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
  end

  scenario 'require image' do
    click_link 'New Post'
    fill_in 'Caption', with: 'sunset'
    click_button 'Create Post'
    expect(page).to have_content('Halt, you fiend! you need an image to post here.')
  end

  scenario 'Can click and view a single post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime'
    click_button 'Create Post'
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('nom nom nom')
  end
end
