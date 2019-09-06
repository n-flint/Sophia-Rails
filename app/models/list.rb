class List < ApplicationRecord
  belongs_to :client
  has_many :tasks

  validates_presence_of :name
end
