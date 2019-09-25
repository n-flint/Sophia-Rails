class Api::V1::TasksController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    list = List.find(params[:list_id])
    render json: list.tasks.map{|task| TaskSerializer.new(task)}
  end

  def show
    list = List.find(params[:list_id])
    task = list.tasks.find(params[:id])
    render json: TaskSerializer.new(task)
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not Found' }, status: 404
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: TaskSerializer.new(task)
    else
      render json: task.errors, status: 400
    end
  end

  private

  def task_params
    params.permit(:name, :description, :list_id, :due_date)
  end
end
