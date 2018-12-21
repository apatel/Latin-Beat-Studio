Rails.application.routes.draw do
  resources :accounts do
    collection do
      get :profile
      get :qr_code
      get :classes
      get :past_classes
      get :packages
      get :past_packages
      get :admin
      get :autocomplete
      get :clear
      get :member
    end
  end
  resources :contents
  resources :purchases do
    collection do
      get :add
    end
  end
  resources :pages
  resources :class_registrations do
    collection do
      get :register
      get :roster
      get :attended
      get :cancel
      get :no_show
      get :submit
      get :paid
      get :qr_scan
    end
  end
  resources :instructors
  resources :studio_events
  resources :events
  resources :passes do
    collection do
      get :buy
      get :remove
    end
  end
  resources :locations
  devise_for :users
  resources :class_types
  get '/studio' => 'main#studio', as: 'studio'
  get '/faq' => 'main#faq', as: 'faq'
  get '/schedule' => 'main#schedule', as: 'schedule'
  # get '/account' => 'main#account', as: 'account'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount FullcalendarEngine::Engine => "/fullcalendar", as: 'fullcalendar'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'
end
