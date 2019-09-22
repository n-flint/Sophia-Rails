class Api::V1::Caretakers::ListsController < ApplicationController
  def index
    caretaker = Caretaker.find(params[:id])
    render json: caretaker.lists
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  def show
    caretaker = Caretaker.find(params[:id])
    if list = caretaker.lists.find(params[:list_id])
      render json: list, status: 200
    else
      render json: list.errors, status: 404
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end
end
