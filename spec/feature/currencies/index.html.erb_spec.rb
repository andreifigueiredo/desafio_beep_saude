require 'rails_helper'

RSpec.describe "currencies/index.html.erb", type: :feature do
  it "click in all tabs" do
    visit '/currencies/index'
    find('#tab2').click
    find('#tab1').click
    find('#tab3').click
    expect(page).to have_content 'PESOS ARGENTINOS'
  end
end
