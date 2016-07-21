require 'rails_helper.rb'

feature 'Creating posts' do
  background 'Click on New Post' do
    visit '/'
    click_link 'New Post'
  end
  scenario 'can create a job' do
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
  end

  scenario 'require image' do
    fill_in 'Caption', with: 'sunset'
    click_button 'Create Post'
    expect(page).to have_content('Halt, you fiend! you need an image to post here.')
  end
end

feature 'Can view individual post' do
  scenario 'Can click and view a single post' do
    post = create(:post)
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end
end
