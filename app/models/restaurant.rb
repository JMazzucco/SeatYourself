class Restaurant < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, if: :address_changed?

	validates :name, :address, :cuisine_type, :website, presence: true


	has_many :reservations
	has_many :reviews
	has_many :users, through: :reservations

end
