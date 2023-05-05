Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:show, :new, :create, :edit, :update, :index]
  resources :product_models, only: [:show, :new, :create, :edit, :update, :index]
end
