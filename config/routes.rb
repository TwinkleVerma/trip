Rails.application.routes.draw do
  match 'twilio/voice', defaults: { format: 'xml' }, via: [:GET, :POST]
  match 'twilio/avialable', defaults: { format: 'xml' }, via: [:GET, :POST]
  require 'sidekiq/web'
  get 'crews/index'
  root to: 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users, except: :show
  match "/calendar" => "schedules#calendar", as: :calendar, via: [:get]
  match '/event' => "schedules#event", as: :event, defaults: { format: 'json' }, via: [:GET]
  resources :users, only: :show do
    match "/call" => "logs#call", as: :call, via: [:post]
    match "/callback" => "logs#callback", as: :callback, via: [:post, :get]
    resources :logs
    resource :crews, on: :collection do
      resources :flights, on: :collection, only: [:show, :index]
    end
    resources :bookings, only: [:create, :index]
    resource :image, on: :member
  end
  resources :bookings, except: [:create, :index]

  resources :flights, only: [:show, :index, :update, :destroy, :edit] do
    resources :schedules, only: :index
  end

  resources :airlines do
    resource :image, on: :member
    resources :flights, only: [:create, :new, :index] do
      resources :schedules, on: :member, only: :index
    end
  end

  resources :schedules do
    resources :disable_schedules
  end

  resources :itineraries, only: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: '/sidekiq'
end
