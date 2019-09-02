Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :clients, only: [:show]
      patch '/clients/:id', to: 'clients#update'
    end
  end
end
