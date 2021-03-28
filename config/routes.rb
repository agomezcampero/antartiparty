Rails.application.routes.draw do
  root to: 'games#new'
  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
      resources :bets, only: [:create]
      resources :games, only: [:create]
      resources :rounds, only: [:create]
    end
  end
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Sidekiq::Web => '/queue'
  mount ActionCable.server => '/cable'

  resources :games, only: [:show, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
