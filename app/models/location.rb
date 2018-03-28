class Location < ApplicationRecord
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
