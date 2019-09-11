class Api::V1::Caretakers::TasksController < ApplicationController
  protect_from_forgery with: :null_session

  # def create
  #   new_task = Task.new(task_params)
  #   if new_task.save
  #     render json: TaskSerializer.new(new_task), status: 201
  #   else
  #     render json: new_task.errors, status: 404
  #   end
  # end

  def index
    # require 'pry'; binding.pry
    caretaker = Caretaker.find(params[:id])
    list = caretaker.lists.find(params[:list_id])
    render json: list.tasks.map{|task| TaskSerializer.new(task)}
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  # def update
  #   client = Client.find(params[:client_id])
  #   list = client.lists.find(params[:list_id])
  #   task = list.tasks.find(params[:id])
  #   task.update_attributes(task_params)
  #   render json: TaskSerializer.new(task)
  # rescue ActiveRecord::RecordNotFound
  #   render json: { message: "Not Found" }, status: 404
  # end

  # def destroy
  #   client = Client.find(params[:client_id])
  #   list = client.lists.find(params[:list_id])
  #   task = list.tasks.find(params[:id])
  #   task.destroy
  #   render json: {}, status: 204
  # rescue ActiveRecord::RecordNotFound
  #   render json: { message: "Not Found" }, status: 404
  # end

  private

  def task_params
    params.permit(:description, :name, :completed, :due_date, :list_id)
  end
end
