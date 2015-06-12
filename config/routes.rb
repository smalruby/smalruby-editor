# -*- coding: utf-8 -*-
SmalrubyEditor::Application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    root to: 'editor#index'
  end

  match '/demo(/:filename)' => 'editor#demo',
        defaults: { filename: 'car_chase' }, via: :get

  resources :sessions, only: [:create, :destroy]
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :users, only: [:update]
  resources :costumes, only: [:index, :create, :destroy]
  get "/smalruby/assets/:basename", to: "costumes#show"

  resources :source_codes, only: [:create, :index]
  post 'source_codes/check'
  delete 'source_codes/download'
  post 'source_codes/load'
  post 'source_codes/load_local'
  post 'source_codes/load_demo'
  delete 'source_codes/write'
  post 'source_codes/run'
  post 'source_codes/to_blocks'

  get 'preferences', to: 'users#preferences'
  get 'toolbox', to: 'editor#toolbox'
end
