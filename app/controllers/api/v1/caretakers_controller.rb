class Api::V1::CaretakersController < ApplicationController

  def create
    new_caretaker = CareTaker.new(caretaker_params)
    if new_caretaker.save
      render json: new_caretaker, status: 201
    else
      render json: new_characters.errors, status: 404
    end
  end


  private

  def caretaker_params
    params.require(:caretaker).permit(:username, :password, :password_confirmation, :name, :email, :phone_number, :abilities)
  end
end