class Client < ApplicationRecord
  validates_presence_of :username,
                        :name,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :phone_number

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :lists
  has_secure_password
end
