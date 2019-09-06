class Api::V1::ListsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    new_list = List.new(list_params)
    if new_list.save
      render json: new_list, status: 201
    else
      render json: new_list.errors, status: 404
    end
  end

  def index
    if Client.exists?(params[:client_id])
      client = Client.find(params[:client_id])
      render json: client.lists
    else
      render json: { message: "Not Found" }, status: 404
    end
  end

  def update
    if Client.exists?(params[:client_id]) && List.exists?(params[:id])
      client = Client.find(params[:client_id])
      list = client.lists.find(params[:id])
      list.update_attributes({ name: params[:name] })
      render json: list
    else
      render json: { message: "Not Found" }, status: 404
    end
  end

  private

  def list_params
    list_params = params.require(:list).permit(:name)
    list_params['client_id'] = params['client_id']
    list_params
  end
end
