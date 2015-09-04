class Location < ActiveRecord::Base
	geocoded_by :address
end
