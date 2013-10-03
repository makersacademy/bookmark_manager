require 'spec_helper'

feature "User adds a new link" do

  scenario "without tags" do
    expect(Link.count).to eq(0)
    visit '/links/new'
    add_link("http://www.makersacademy.com/", "Makers Academy")
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq("http://www.makersacademy.com/")
    expect(link.title).to eq("Makers Academy")
  end

  scenario "with a few tags" do
    visit "/links/new"
    add_link("http://www.makersacademy.com/", "Makers Academy", ['education', 'ruby'])    
    link = Link.first
    expect(link.tags.map(&:text)).to include("education")
    expect(link.tags.map(&:text)).to include("ruby")
  end

  scenario "from the homepage using an ajax form", :js => true do
    visit '/'
    click_link "Add link"
    add_link("http://www.example.com/", "Example")
    expect(page).to have_content('Example')
    expect(current_path).to eq('/')
  end

  def add_link(url, title, tags = [])    
    fill_in 'url', :with => url
    fill_in 'title', :with => title
    # our tags will be space separated
    fill_in 'tags', :with => tags.join(' ')
    click_button 'Add link'
  end

end