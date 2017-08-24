require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  #pending "add some scenarios (or delete) #{__FILE__}"
  
  #scenario is lke a grouping mechanism
  
  scenario 'User views the /cars page' do
      car =  Car.first # tis is used to get the id of the car so that it can be passed to the URL id
    visit '/cars'
    expect(page).to have_text('Cars')
    expect(page).to have_text('Toyota')
    expect(page.html).to include('<h1>Cars</h1>')
    expect(page).to have_link('New', href: '/cars/new')
    expect(page).to have_link(car.vin, href: "/cars/#{car.id}")
  end
  
  scenario 'User views their car show page' do
     car =  Car.first
     
     visit '/cars'
     click_link car.vin
     expect(page).to have_text(car.vin)
     expect(page).to have_text(car.make)
     expect(page).to have_text(car.model)
     expect(page).to have_text(car.year)
     expect(page).to have_link('Edit', href: "/cars/#{car.id}/edit")
     expect(page).to have_link('Delete', href: "/cars/#{car.id}")
  end
  
    scenario 'User delete a car' do
     car =  Car.first
     
     visit '/cars'
     click_link car.vin
     click_link 'Delete'
     
     expect(page).to have_text('Cars') #after redirecting
     expect(page).to_not have_text(car.vin) #vin shd not exist
     
  end

    scenario 'User creates a car' do
    
     visit '/cars/new'

     expect(page).to have_text('New Car') #after redirecting
     #car[vin] is the name of the html text field can be found using inpect/browser debugger
     fill_in 'car[vin]', with: 'C0000000000000001'
     fill_in 'car[make]', with: 'AMC'
     fill_in 'car[model]', with: 'Gremlin'
     fill_in 'car[year]', with: '1973'
     click_button 'Create Car'

     expect(page).to have_text('C0000000000000001') 
     expect(page).to have_text('AMC') 
     expect(page).to have_text('Gremlin') 
     expect(page).to have_text('1973') 
     #fill_in '', with: ''
     
  end


    scenario 'User creates an invalid car' do
    
     visit '/cars/new'

     expect(page).to have_text('New Car') #after redirecting
     #car[vin] is the name of the html text field can be found using inpect/browser debugger
     fill_in 'car[vin]', with: 'C000000000000001'
     fill_in 'car[make]', with: 'AMC'
     fill_in 'car[model]', with: 'Gremlin'
     fill_in 'car[year]', with: '1700'
     click_button 'Create Car'

     expect(page).to have_text('Vin invalid representation') 
     expect(page).to have_text('Year is not a valid year') 
     #fill_in '', with: ''
     
  end

    scenario 'User edits a car' do
    
     car =  Car.first
     visit "/cars/#{car.id}/edit"
        
     expect(page).to have_text('Edit Car') #after redirecting
     fill_in 'car[vin]', with: 'C000000000000001'
     fill_in 'car[make]', with: 'AMC'
     fill_in 'car[model]', with: 'Gremlin'
     fill_in 'car[year]', with: '1700'
     click_button 'Update Car'

     expect(page).to have_text('Vin invalid representation') 
     expect(page).to have_text('Year is not a valid year') 

     
     
     
     
     expect(page).to have_text('Edit Car') #after redirecting
     
  end

end

