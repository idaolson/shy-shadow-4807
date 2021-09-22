class Garden < ApplicationRecord
  has_many :plots

  def garden_plants
    garden_plants = self.plots.select('plots.*, plants.name, plants.days_to_harvest')
    .joins(:plants).where('plants.days_to_harvest < 100')
    .pluck('plants.name')
    garden_plants.uniq
  end
end
