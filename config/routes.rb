Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :users, only: :show do
    resources :bookings, only: [:create, :index]
    resource :image, on: :member
  end
  resources :bookings, except: [:create, :index]

  resources :flights, only: [:show, :index, :update, :destroy, :edit]

  resources :airlines do
    resource :image, on: :member
    resources :flights, only: [:create, :new] do
      resources :schedules, on: :member, only: :index
    end
  end

  resources :schedules

  resources :itineraries, only: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
