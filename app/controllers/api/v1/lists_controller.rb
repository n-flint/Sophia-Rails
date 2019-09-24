class Api::V1::ListsController < ApplicationController
  def index
    client = find_client
    caretaker = find_caretaker
    render_lists(client, caretaker)
  end

  private

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
