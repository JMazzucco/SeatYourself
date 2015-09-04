class Reservation < ActiveRecord::Base
	validates :party_size, numericality: true
	belongs_to :user
	belongs_to :restaurant
end
