class Caretaker < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # validates_presence_of :password, require: true
  validates_presence_of :phone_number
  validates_presence_of :name


  has_many :lists, dependent: :destroy
  has_secure_password
end