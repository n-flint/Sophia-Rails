class Api::V1::TasksController < ApplicationController
  def index
    list = List.find(params[:list_id])
    render json: list.tasks.map{|task| TaskSerializer.new(task)}
  end
end
