Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :clients, only: [:show]
    end
  end
end
