class ClientSerializer
  def initialize(data)
    @id = data.id
    @username = data.username
    @name = data.name
    @street_address = data.street_address
    @city = data.city
    @state = data.state
    @zip = data.zip
    @email = data.email
    @phone_number = data.phone_number
    @needs = data.needs.split(', ') if data.needs
    @allergies = data.allergies.split(', ') if data.allergies
    @medications = data.medications.split(', ') if data.medications
    @diet_restrictions = data.diet_restrictions.split(', ') if data.diet_restrictions
    @created_at = data.created_at
    @updated_at = data.updated_at
  end
end
