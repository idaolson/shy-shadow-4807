class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @garden_plants = @garden.garden_plants
  end
end
