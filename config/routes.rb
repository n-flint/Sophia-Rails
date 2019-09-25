Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do

      post '/speech', to: 'speech#index'
      post '/login', to: 'login#create'

      resources :clients, only: [:show, :update, :create, :destroy]

      resources :caretakers, only: [:create, :update, :destroy, :show, :index]

      resources :lists, only: [:index, :show, :create, :update, :destroy] do
        resources :tasks, only: [:index]
      end

    end
  end
end
