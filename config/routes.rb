Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins, only: [:new, :create, :edit, :update, :destroy]

  namespace :admin do
  end

  scope :admin do
  	get '/login/', to: 'sessions#new'
  	post '/login/', to: 'sessions#create'
  	delete '/login/', to: 'sessions#destroy'

  	resources :recipes, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :recipes, only: [:index, :show]

  root 'admins#new'
end
