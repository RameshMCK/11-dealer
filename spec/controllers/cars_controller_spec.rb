require 'rails_helper'

RSpec.describe CarsController, type: :controller do
    render_views #need to do this to get the forms associated with the controller
    describe 'GET /cars/:id' do
        it 'displays a car' do
            
            car1  =Car.first
            get :show, params: {id: car1.id}
            car2 = assigns(:car) # :car is is the instance variable from the controller show method above
            expect(car2.id).to eql(car1.id)
            expect(response.status).to eql(200) #find using pry
            expect(response.body).to include(car2.vin) #find using pry
        end
    end
end
