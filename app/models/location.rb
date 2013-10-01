class Location < ActiveRecord::Base

validates :address, :state, :country , :presence => true
validate :zipcode, length: { is: 5 }
has_many :users

end
