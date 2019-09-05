Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :clients, only: [:show, :update, :create, :destroy] do
        resources :lists, only: [:create] do
          resources :tasks, only: [:create]
        end
      end
    end
  end
end
