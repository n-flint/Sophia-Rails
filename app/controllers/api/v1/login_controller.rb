class Api::V1::LoginController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    client = find_client
    caretaker = find_caretaker
    if client && client.authenticate(params[:password])
      render json: ClientSerializer.new(client)
    elsif caretaker && caretaker.authenticate(params[:password])
      render json: CaretakerSerializer.new(caretaker)
    else
      render json: { message: "Incorrect Username/Password Combination" }, status: 400
    end
  end

  private

  def find_client
    Client.find_by(username: params[:username])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def find_caretaker
    Caretaker.find_by(username: params[:username])
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
