class Api::V1::Caretakers::TasksController < ApplicationController
  def index
    caretaker = Caretaker.find(params[:id])
    list = caretaker.lists.find(params[:list_id])
    render json: list.tasks.map{|task| TaskSerializer.new(task)}
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  def update
    caretaker = Caretaker.find(params[:id])
    list = caretaker.lists.find(params[:list_id])
    task = list.tasks.find(params[:task_id])
    task.update_attributes(task_params)
    render json: TaskSerializer.new(task)
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  private

  def task_params
    params.permit(:description, :name, :completed, :due_date, :list_id)
  end
end
