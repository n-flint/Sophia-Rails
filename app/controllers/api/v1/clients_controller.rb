class Api::V1::ClientsController < ApplicationController
  def show
    if Client.exists?(params[:id])
      render json: Client.find(params[:id])
    else
      render json: { message: "Not Found" }, status: 404
    end
  end

  def destroy
    if Client.exists?(params['id'])
      Client.find(params['id']).destroy
      render json: {}, status: 204
    else
      render json: { message: "Invalid ID" }, status: 404
    end
  end

  def update
    if Client.exists?(:username => client_params['username'])
      render json: { message: "Username Must Be Unique" }, status: 404
    elsif Client.exists?(:email => client_params['email'])
      render json: { message: "Email Must Be Unique" }, status: 404
    else
      client = Client.find(params['id'])
      client.update(client_params)
      client.save
      render json: client, status: 200
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
