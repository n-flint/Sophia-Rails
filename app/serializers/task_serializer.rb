class TaskSerializer
  def initialize(data)
    @id = data.id
    @list_id = data.list_id
    @name = data.name
    @description = data.description
    @completed = data.completed
    @priority = data.priority
    @created_at = data.created_at
    @updated_at = data.updated_at
    @due_date = data.due_date.strftime("%m/%d") if data.due_date
  end
end
