class Api::V1::CaretakersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    caretakers = Caretaker.all
    render json: caretakers.map{|caretaker| CaretakerSerializer.new(caretaker)}, status: 200
  end

  def create
    new_caretaker = Caretaker.new(caretaker_params)
    if params[:abilities]
      abilities = params[:abilities].join(', ')
      new_caretaker.update(abilities: abilities)
    end
    if new_caretaker.save
      render json: CaretakerSerializer.new(new_caretaker, params[:password]), status: 201
    else
      render json: new_caretaker.errors, status: 400
    end
  end

  def show
    if Caretaker.exists?(id: params['id'])
      caretaker = Caretaker.find(params['id'])
      render json: CaretakerSerializer.new(caretaker), status: 200
    else
      render json: { message: 'Invalid ID'}, status: 404
    end
  end

  def update
    if Caretaker.exists?(username: caretaker_params['username'])
      render json: { message: "Username Must Be Unique" }, status: 404
    elsif Caretaker.exists?(email: caretaker_params['email'])
      render json: { message: "Email Must Be Unique" }, status: 404
    elsif Caretaker.exists?(id: params['id'])
      caretaker = Caretaker.find(params['id'])
      abilities = params[:abilities].join(', ')
      caretaker.update(caretaker_params)
      caretaker.update(abilities: abilities)
      render json: CaretakerSerializer.new(caretaker), status: 200
    else
      render json: { message: "Invalid ID" }, status: 404
    end
  end

  def destroy
    Caretaker.find(params['id']).destroy
    render json: {}, status: 204
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Invalid ID'}, status: 404
  end

  private

  def caretaker_params
    params.permit(:role, :username, :password, :password_confirmation, :name, :email, :phone_number)
  end
end
