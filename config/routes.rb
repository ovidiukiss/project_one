require 'sidekiq/web'

# frozen_string_literal: true

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams do
    get :download_logo, on: :member
  end

  resources :managers, only: %i[index show create update]
  resources :bulks, only: %i[index show create]
  resources :many_attachments, only: %i[index show create]
end
