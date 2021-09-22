require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'model tests' do
    before :each do
      @garden = Garden.create!(name: "Cheyenne Botanical Garden", organic: true)
      @plot1 = @garden.plots.create!(number: 10, size: "medium", direction: "north")
      @plot2 = @garden.plots.create!(number: 15, size: "large", direction: "south")
      @plot3 = @garden.plots.create!(number: 30, size: "extra-large", direction: "west")
      @plant1 = Plant.create!(name: "tomato", description: "yummy", days_to_harvest: 5)
      @plant2 = Plant.create!(name: "carrot", description: "crunchy", days_to_harvest: 21)
      @plant3 = Plant.create!(name: "broccoli", description: "bitter", days_to_harvest: 101)
      @plant4 = Plant.create!(name: "pea", description: "sweet", days_to_harvest: 13)

      @plot1.plants << @plant1
      @plot1.plants << @plant3
      @plot1.plants << @plant4

      @plot2.plants << @plant2
      @plot2.plants << @plant3
      @plot2.plants << @plant4

      @plot3.plants << @plant1
      @plot3.plants << @plant4
    end

    it "returns garden's plants' names without duplicates if they take less than 100 days to harvest" do
      expect(@garden.garden_plants).to eq(["tomato", "pea", "carrot"])
    end
  end
end
