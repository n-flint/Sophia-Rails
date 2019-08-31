class WelcomeController < ApplicationController
  def index
    render json: { message: "Welcome to the landing page of Sophia's back end"}
  end
end
