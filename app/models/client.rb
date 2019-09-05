class Client < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true
  validates_presence_of :username,
                        :password,
                        :name,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :phone_number


  has_many :lists
  has_secure_password
end
