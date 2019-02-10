Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins, only: [:new, :create, :edit, :update, :destroy]
  namespace :admin do
  	get '/login/', to: 'sessions#new'
  	post '/login/', to: 'sessions#create'
  	delete '/login', to: 'sessions#destroy'
  end

  root 'admins#new'
end
