class Api::V1::ClientsController < ApplicationController
  def show
    if Client.exists?(params[:id])
      render json: Client.find(params[:id])
    else
      render json: { message: "Not Found" }, status: 404
    end
  end

  def create
    new_client = Client.new(client_params)
    if new_client.save
      render json: new_client, status: 201
    else
      render json: new_client.errors, status: 400
    end
  end

  private

  def client_params
    params.require(:client).permit(:username, :name, :email, :phone_number, :street_address, :city, :state, :zip, :needs, :allergies, :medications)
  end
end
