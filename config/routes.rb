Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      # client lists
      post '/clients/:id/lists', to: 'clients/lists#create'
      get '/clients/:id/lists', to: 'clients/lists#index'
      get '/clients/:id/lists', to: 'clients/lists#show'
      patch '/clients/:id/lists/:list_id', to: 'clients/lists#update'
      delete '/clients/:id/lists/:list_id', to: 'clients/lists#destroy'

      # caretaker lists
      get '/caretakers/:id/lists', to: 'caretakers/lists#index'

      # caretaker list tasks
      get '/caretakers/:id/lists/:list_id/tasks', to: 'caretakers/tasks#index'

      post '/speech', to: 'speech#index'
      post '/login', to: 'login#create'

      resources :clients, only: [:show, :update, :create, :destroy] do
        resources :lists do
          resources :tasks, only: [:create, :index, :update, :destroy]
        end
      end

      resources :caretakers, only: [:create, :update, :destroy, :show, :index]
    end
  end
end
