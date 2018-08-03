Rails.application.routes.draw do
  root to: "home#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  
  resources :users, only: :show do
    resources :bookings, only: [:index, :create, :new]
    resource :image, on: :member
  end
  resource :bookings, except: [:index, :create, :new]

  resources :flights, only: [:show, :index, :update, :destroy, :edit] do
    get 'find', on: :collection
  end

  resources :airlines do
    resources :flights, only: [:create, :new] do
      get :schedules, on: :member
    end
  end

  resources :schedules, only: [:show, :create, :update, :destroy, :new, :edit] do
    resources :bookings, only: [:index, :new, :create], on: :member 
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
