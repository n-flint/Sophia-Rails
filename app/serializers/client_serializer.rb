class ClientSerializer
  def initialize(data)
    @username = data.username
    @name = data.name
    @street_address = data.street_address
    @city = data.city
    @state = data.state
    @zip = data.zip
    @email = data.email
    @phone_number = data.phone_number
    @needs = data.needs.split(', ')
    @allergies = data.allergies.split(', ')
    @medications = data.medications.split(', ')
    @created_at = data.created_at
    @updated_at = data.updated_at
  end
end
