class Api::V1::Caretakers::ListsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    caretaker = Caretaker.find(params[:id])
    render json: caretaker.lists
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end
end