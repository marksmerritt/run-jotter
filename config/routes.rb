Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check
  root "marketing/pages#index"

  scope module: :marketing, controller: "pages" do
    get :features
    get :pricing
    get :faqs
  end

  scope module: :identity do
    get :sign_up, to: "sign_ups#new"
    post :sign_up, to: "sign_ups#create"
    resource :sign_up, only: [:edit, :update]
    get :sign_in, to: "sign_ins#new"
    post :sign_in, to: "sign_ins#create"
    delete :sign_out, to: "sign_ins#destroy"
    resource :password_reset
    resource :email_verification
    resource :password
    resources :google_accounts
  end

  scope module: :app do
    resource :dashboard, controller: "dashboard"
    get :profile, to: "profiles#edit"
    patch :profile, to: "profiles#update"

    namespace :calendars, as: "" do
      get :weekly, to: "weekly#show", as: :weekly_calendar
      get :daily, to: "weekly#show", as: :daily_calendar
    end
  end
end
