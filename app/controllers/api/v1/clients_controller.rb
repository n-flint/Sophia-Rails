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
      render json: {status: 204}
    else
      render json: { message: "Invalid ID" }, status: 404
    end
  end
end
