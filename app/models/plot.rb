class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plots, through: :plot_plants
end
