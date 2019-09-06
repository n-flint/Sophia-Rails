class Api::V1::TasksController < ApplicationController

  def create
    new_task = Task.new(task_params)
    if new_task.save
      render json: new_task, status: 201
    else
      render json: new_task.errors, status: 404
    end
  end

  def index
    client = Client.find(params[:client_id])
    list = client.lists.find(params[:list_id])
    render json: list.tasks
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  private

  def task_params
    params.require(:task).permit(:description, :name, :completed, :due_date, :list_id)
  end
end
