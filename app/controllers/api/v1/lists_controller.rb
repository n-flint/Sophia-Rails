class Api::V1::ListsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    client = find_client
    caretaker = find_caretaker
    render_lists(client, caretaker)
  end

  def show
    list = List.find(params[:id])
    render json: list
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not Found' }, status: 404
  end

  def create
    list = List.new(list_params)
    if list.save
      render json: list
    else
      render json: list.errors, status: 400
    end
  end

  private

  def list_params
    params.permit(:name, :client_id, :caretaker_id)
  end

  def render_lists(client, caretaker)
    if client
      render json: client.lists
    elsif caretaker
      render json: caretaker.lists
    else
      render json: { message: 'Not Found' }, status: 404
    end
  end

  def find_client
    Client.find(params[:client_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def find_caretaker
    Caretaker.find(params[:caretaker_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
