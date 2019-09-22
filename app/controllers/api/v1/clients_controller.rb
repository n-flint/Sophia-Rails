class Api::V1::ClientsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  wrap_parameters :client, include: [:username,
                                     :password,
                                     :password_confirmation,
                                     :name,
                                     :email,
                                     :phone_number,
                                     :street_address,
                                     :city,
                                     :state,
                                     :zip,
                                     :role]

  def show
    render json: ClientSerializer.new(Client.find(params[:id]))
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not Found" }, status: 404
  end

  def destroy
    Client.find(params['id']).destroy
    render json: {}, status: 204
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Invalid ID" }, status: 404
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
      client.custom_needs(params)
      render json: ClientSerializer.new(client), status: 200
    end
  end

  def create
    new_client = Client.new(client_params)
    needs = params[:needs].join(', ')
    medications = params[:medications].join(', ')
    allergies = params[:allergies].join(', ')
    diet_restrictions = params[:diet_restrictions].join(', ')
    new_client.update_attributes(diet_restrictions: diet_restrictions, needs: needs, medications: medications, allergies: allergies)
    if new_client.save
      render json: ClientSerializer.new(new_client, params[:password]), status: 201
    else
      render json: new_client.errors, status: 400
    end
  end

  private

  def client_params
    params.require(:client).permit(:username,
                                   :password,
                                   :password_confirmation,
                                   :name,
                                   :email,
                                   :phone_number,
                                   :street_address,
                                   :city,
                                   :state,
                                   :zip,
                                   :role
                                )
  end
end
