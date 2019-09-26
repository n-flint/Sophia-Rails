class Api::V1::TasksController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    list = List.find(params[:list_id])
    render json: list.tasks.map{|task| TaskSerializer.new(task)}
  end

  def show
    task = Task.find(params[:id])
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

  def update
    task = Task.find(params[:id])
    task.update_attributes(task_params)
    render json: TaskSerializer.new(task)
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not Found' }, status: 404
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    render json: {}, status: 204
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not Found' }, status: 404
  end

  private

  def task_params
    params.permit(:name, :description, :list_id, :due_date, :priority, :completed)
  end
end
