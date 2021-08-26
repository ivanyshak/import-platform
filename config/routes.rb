Rails.application.routes.draw do
  root "imports#index"

  resources :imports do
    member do
      post :start_process
      post :remove_customers
    end
  end
end
