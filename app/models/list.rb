class List < ApplicationRecord
  belongs_to :client

  validates_presence_of :name
end