class Api::V1::TasksController < ApplicationController
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
end
