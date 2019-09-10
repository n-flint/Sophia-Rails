class Api::V1::CaretakersController < ApplicationController

  def create
    new_caretaker = Caretaker.new(caretaker_params)
    if new_caretaker.save
      render json: new_caretaker, status: 201
    else
      render json: new_caretaker.errors, status: 400
    end
  end

  def update
    if Caretaker.exists?(username: caretaker_params['username'])
      render json: { message: "Username Must Be Unique" }, status: 404
    elsif Caretaker.exists?(email: caretaker_params['email'])
      render json: { message: "Email Must Be Unique" }, status: 404
    elsif Caretaker.exists?(id: params['id'])
      caretaker = Caretaker.find(params['id'])
      caretaker.update(caretaker_params)
      render json: caretaker, status: 200
    else
      render json: { message: "Invalid ID" }, status: 404
    end
  end

  private

  def caretaker_params
    # is this still secure when I am not using the require method?
    params.permit(:username, :password, :password_confirmation, :name, :email, :phone_number, :abilities)
  end
end