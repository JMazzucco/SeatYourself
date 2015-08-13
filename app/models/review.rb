class Review < ActiveRecord::Base
	validates :title, :comment, presence: true

	belongs_to :user
	belongs_to :restaurant
end
