class CarsController < ApplicationController
    
    def index
        @cars =  Car.all
    end
    
    def show
        @car = Car.find(params[:id])
    end
    
    def destroy
        car = Car.find(params[:id])
        car.destroy
        redirect_to cars_path
    end
    
    def new
        @car =  Car.new
    end
    
   def create
        @car = Car.new(params[:car].permit(:make, :model, :year, :vin))
        if @car.save
            redirect_to cars_path
        else
            render 'new'
        end
        
    end    
    
    def edit
        @car = Car.find(params[:id])
        
    end
    
    def update
        @car = Car.find(params[:id])
        if @car.update(params[:car].permit(:make, :model, :year, :vin))
          redirect_to @car
        else
          render 'edit'
        end
    end
  end