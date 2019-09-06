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

  def custom_needs(params)
    if params[:needs]
      needs = params[:needs].join(', ')
      update_attributes(needs: needs)
    end
    if params[:diet_restrictions]
      diet_restrictions = params[:diet_restrictions].join(', ')
      update_attributes(diet_restrictions: diet_restrictions)
    end
    if params[:medications]
      medications = params[:medications].join(', ')
      update_attributes(medications: medications)
    end
    if params[:allergies]
      allergies = params[:allergies].join(', ')
      update_attributes(allergies: allergies)
    end
  end
end
