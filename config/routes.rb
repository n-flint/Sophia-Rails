Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      post '/speech', to: 'speech#index'
      post '/login', to: 'login#create'
      resources :clients, only: [:show, :update, :create, :destroy] do
        resources :lists, only: [:create, :index, :update, :destroy] do
          resources :tasks, only: [:create, :index, :update, :destroy]
        end
      end
      resources :caretakers, only: [:create, :update, :destroy]
    end
  end
end
