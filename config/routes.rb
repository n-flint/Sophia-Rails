Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      post '/speech', to: 'speech#index'
      resources :clients, only: [:show, :update, :create, :destroy] do
        resources :lists, only: [:create]
      end
    end
  end
end
