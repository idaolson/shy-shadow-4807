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

  it "has a button to disassociate plants from plots" do
    visit plots_path

    # save_and_open_page

    within("#plot-#{@plot1.id}") do
      within("#plant-#{@plant1.id}") do
        click_on "Remove"
      end

      expect(page).to have_no_content("tomato")
      expect(page).to have_content("broccoli")
      expect(current_path).to eq(plots_path)
    end

    within("#plot-#{@plot2.id}") do
      within("#plant-#{@plant2.id}") do
        click_on "Remove"
      end

      expect(page).to have_no_content("carrot")
      expect(current_path).to eq(plots_path)
    end

    within("#plot-#{@plot3.id}") do
      within("#plant-#{@plant4.id}") do
        click_on "Remove"
      end

      expect(page).to have_no_content("pea")
      expect(current_path).to eq(plots_path)
    end

    expect(@plant1).to be_a(Plant)
    expect(@plant2).to be_a(Plant)
    expect(@plant4).to be_a(Plant)
  end
end



# ```
# User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit a plot's index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot
# (Note: you should not destroy the plant record entirely)
# ```
