require 'rails_helper'

RSpec.describe "currencies/index.html.erb", type: :feature do
  it "click in all tabs" do
    visit '/currencies/index'
    find('#tab2').click
    expect(page).to have_selector("//.tab2", visible: true)
    expect(page).to have_selector("//.tab3", visible: false)
    expect(page).to have_selector("//.tab1", visible: false)
    find('#tab1').click
    expect(page).to have_selector("//.tab1", visible: true)
    expect(page).to have_selector("//.tab2", visible: false)
    expect(page).to have_selector("//.tab3", visible: false)
    find('#tab3').click
    expect(page).to have_selector("//.tab3", visible: true)
    expect(page).to have_selector("//.tab2", visible: false)
    expect(page).to have_selector("//.tab1", visible: false)
  end
end