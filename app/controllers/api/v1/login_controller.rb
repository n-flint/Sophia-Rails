class Api::V1::LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    client = Client.find_by(username: params[:username])
    if client && client.authenticate(params[:password])
      render json: ClientSerializer.new(client)
    else
      render json: { message: "Incorrect Username/Password Combination" }, status: 400
    end
  end
end