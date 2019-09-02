class Api::V1::ClientsController < ApplicationController
  def show
    if Client.exists?(params[:id])
      render json: Client.find(params[:id])
    else
      render json: { message: "Not Found" }, status: 404
    end
  end

  def create
    if Client.exists?(:username => client_params['username'])
        render json: { message: "Username Must Be Unique" }, status: 404
    elsif Client.exists?(:email => client_params['email'])
          render json: { message: "Email Must Be Unique" }, status: 404
    else new_client = Client.create(client_params)
          render json: new_client, status: 201
    end
  end

  private

  def client_params
    params.require(:client).permit(:username, :name, :email, :phone_number, :street_address, :city, :state, :zip, :needs, :allergies, :medications)
  end
end
