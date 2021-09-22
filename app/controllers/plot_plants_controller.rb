class PlotPlantsController < ApplicationController
  def destroy
    @plot_plant = PlotPlant.find(plot_plant_params[:id]).destroy
    redirect_to '/plots'
  end

  private

  def plot_plant_params
    params.permit(:id)
  end
end
