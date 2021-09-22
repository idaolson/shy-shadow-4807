require 'rails_helper'

RSpec.describe "gardens show page" do
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

  it "lists plants in the garden's plots that take less than 100 days without duplicates" do
    visit garden_path(@garden)

    expect(page).to have_content(@plant1.name, count: 1)
    expect(page).to have_content(@plant2.name, count: 1)
    expect(page).to have_content(@plant4.name, count: 1)
    expect(page).to have_no_content(@plant3.name)
  end


  it "list plants sorted by most to least appearances in garden's plots" do
    visit garden_path(@garden)

    expect(@plant4.name).to appear_before(@plant1.name)
    expect(@plant1.name).to appear_before(@plant2.name)
    expect(page).to have_no_content(@plant3.name)
  end

end
#
# ```
# Extension,
# As a visitor
# When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)
# ```
