class Restaurant < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, if: :address_changed?

	validates :name, :street, :city, :prov, :cuisine_type, presence: true

	has_many :reservations
	has_many :reviews
	has_many :users, through: :reservations

end
