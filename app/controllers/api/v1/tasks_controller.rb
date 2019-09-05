class Api::V1::TasksController < ApplicationController

  def create
    new_task = Task.new(task_params)
    if new_task.save
      render json: new_task, status: 201
    else
      render json: new_task.errors, status: 404
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :name, :completed, :due_date, :list_id)
  end
end