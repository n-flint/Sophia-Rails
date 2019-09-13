class CaretakerSerializer
  def initialize(caretaker, password=nil)
    @id = caretaker.id
    @username = caretaker.username
    @password = password
    @name = caretaker.name
    @email = caretaker.email
    @phone_number = caretaker.phone_number
    @role = caretaker.role
    @abilities = caretaker.abilities.split(', ') if caretaker.abilities
  end
end
