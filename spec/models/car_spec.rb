# == Schema Information
#
# Table name: cars
#
#  id           :integer          not null, primary key
#  make         :string           not null
#  model        :string           not null
#  year         :integer          not null
#  vin          :string           not null
#  color        :string           default("black")
#  category     :string           default("car")
#  cylinders    :integer          default(4)
#  displacement :float            default(0.0)
#  mpg          :integer          default(0)
#  hp           :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Car, type: :model do
    #CLASS METHODS WITLL HAVE .
  describe '.new' do
    it 'instantiates a Car object' do
      c = Car.new
      expect(c.is_a?(Car)).to be true
      expect(c.attributes.keys.count).to eql(13)
    end
  end

    #INSTANCE METHODS WILL HAVE # 
  describe '#save' do
    context 'happy path' do
      it 'saves a car' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: '0123456789abcdefg')
        c.save
        #binding.pry
        expect(c.id).to_not be_nil
        expect(c.created_at).to_not be_nil
        expect(c.updated_at).to_not be_nil
      end
    end
    context 'invalid data' do
      it 'missing model, year - will not save' do
        c = Car.new(make: 'Ford', vin: 'abcd')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:model].first).to eql("can't be blank")
        expect(c.errors[:year].first).to eql("can't be blank")
      end
      it 'vin number is too short - will not save' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: 'abcd')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].second).to eql("is the wrong length (should be 17 characters)")
      end
      
       it 'vin number has incorrect syntax -will not save' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: '*12345678@ABC#EFZ')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].first).to eql("invalid representation")
      end
      
       it 'vin number already taken -will not save' do
        c = Car.new(make: 'Toyota', model: 'camry', year: 2015, vin: 'A1234567890123456')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].first).to eql("has already been taken")
      end

       it 'make, model, year already exists -will not save' do
        c = Car.new(make: 'Toyota', model: 'camry', year: 2015, vin: 'A1234567890123459')
        c.save
        expect(c.id).to be_nil
       #p c.errors[:make].first
        expect(c.errors[:make].first).to eql("has already been taken")
      end

    #   it 'year should be between 1900- 2020 -will not save' do
    #     c = Car.new(make: 'Toyota', model: 'camry', year: 1500, vin: 'A1234567890123459')
    #     c.save
    #     expect(c.id).to be_nil
    #     p c.errors[:year].first
    #     #expect(c.errors[:make].first).to eql("has already been taken")
    #   end

       it 'category not in the list -will not save' do
        c = Car.new(make: 'Toyota', model: 'camry', year: 2016, vin: 'A1234567890123459', category: 'cars')
        c.save
        expect(c.id).to be_nil
       #p c.errors[:category].first
        expect(c.errors[:category].first).to eql("cars is not a valid category")
      end


       it 'cylinders not in the list -will not save' do
        c = Car.new(make: 'Honda', model: 'civic', year: 2016, vin: 'A0000000000000005', category: 'car', cylinders: 5)
        c.save
        expect(c.id).to be_nil
        #p c.errors[:cylinders].first
        expect(c.errors[:cylinders].first).to eql("5 is not a valid cylinder")
      end

      it 'years not in the range -will not save' do
        c = Car.new(make: 'Honda', model: 'fit', year: 1500, vin: 'A0000000000000005', category: 'car', cylinders: 6)
        c.save
        expect(c.id).to be_nil
        p c.errors[:year].first
        expect(c.errors[:year].first).to eql("1500 is not a valid year")
      end

    end
  end
end