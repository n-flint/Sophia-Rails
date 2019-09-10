class Api::V1::CaretakersController < ApplicationController

  def create
    new_caretaker = Caretaker.new(caretaker_params)
    if new_caretaker.save
      render json: new_caretaker, status: 201
    else
      render json: new_caretaker.errors, status: 400
    end
  end


  private

  def caretaker_params
    # is this still secure when I am not using the require method?
    params.permit(:username, :password, :password_confirmation, :name, :email, :phone_number, :abilities)
  end
end