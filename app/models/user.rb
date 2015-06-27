class User < ActiveRecord::Base
	validates :name, :email, :password, :password_confirmation, presence: true
	has_secure_password

	validates :time_zone,
  inclusion: {
    in: ActiveSupport::TimeZone.zones_map(&:name).keys
  }

	has_many :reservations
	has_many :restaurants, through: :reservations
end
