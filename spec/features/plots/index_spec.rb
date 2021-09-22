require 'rails_helper'

RSpec.describe "plots index" do
  before :each do
    @garden = Garden.create!(name: "Cheyenne Botanical Garden", organic: true)
    @plot1 = @garden.plots.create!(number: 10, size: "medium", direction: "north")
    @plot2 = @garden.plots.create!(number: 15, size: "large", direction: "south")
    @plot3 = @garden.plots.create!(number: 30, size: "extra-large", direction: "west")
    @plant1 = Plant.create!(name: "tomato", description: "yummy", days_to_harvest: 5)
    @plant2 = Plant.create!(name: "carrot", description: "crunchy", days_to_harvest: 21)
    @plant3 = Plant.create!(name: "broccoli", description: "bitter", days_to_harvest: 2)
    @plant4 = Plant.create!(name: "pea", description: "sweet", days_to_harvest: 13)

    @plot1.plants << @plant1
    @plot1.plants << @plant3
    @plot2.plants << @plant2
    @plot3.plants << @plant2
    @plot3.plants << @plant4
  end

  it "lists plot numbers and each plot's plants" do

    visit plots_path

    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)
    expect(page).to have_content(@plot3.number)

    within("#plot-#{@plot1.id}") do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant3.name)
      expect(page).to have_no_content(@plant2.name)
      expect(page).to have_no_content(@plant4.name)
    end

    within("#plot-#{@plot2.id}") do
      expect(page).to have_content(@plant2.name)
      expect(page).to have_no_content(@plant1.name)
      expect(page).to have_no_content(@plant3.name)
      expect(page).to have_no_content(@plant4.name)
    end

    within("#plot-#{@plot3.id}") do
      expect(page).to have_content(@plant2.name)
      expect(page).to have_content(@plant4.name)
      expect(page).to have_no_content(@plant1.name)
      expect(page).to have_no_content(@plant3.name)
    end
  end
end

#
# ```
# User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see names of all that plot's plants
# ```
