require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  #pending "add some scenarios (or delete) #{__FILE__}"
  
  #scenario is lke a grouping mechanism
  
  scenario 'User views the /cars page' do
      car =  Car.first
    visit '/cars'
    expect(page).to have_text('Cars')
    expect(page).to have_text('Toyota')
    expect(page.html).to include('<h1>Cars</h1>')
    expect(page).to have_link('New', href: '/cars/new')
    expect(page).to have_link(car.vin, href: "/cars/#{car.id}")
  end
end
