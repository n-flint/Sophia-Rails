class Api::V1::ClientsController < ApplicationController
  def show
    render json: Client.find(params[:id])
  end
end
