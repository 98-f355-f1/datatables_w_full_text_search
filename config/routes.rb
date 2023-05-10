# frozen_string_literal: true

Rails.application.routes.draw do
  resources :employees do
    member do
      patch :cancel_edit
      post :edit
      post :new
    end
  end

  resources :sales, only: :index

  resource :dashboard, except: %i[index new create edit update destroy] do
    member do
      get :revenue
      get :orders
    end
  end

  root "employees#index"
end
