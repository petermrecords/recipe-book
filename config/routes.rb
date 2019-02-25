Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins, only: [:new, :create, :edit, :update, :destroy]

  scope :admin do
  	get '/login/', to: 'sessions#new'
  	post '/login/', to: 'sessions#create'
  	delete '/login/', to: 'sessions#destroy'

  	resources :recipes, only: [:new, :create, :edit, :update, :destroy] do
      resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
      resources :steps, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :groceries, only: [:new, :create, :edit, :update, :destroy]
    get '/', to: 'recipes#new', as: 'admin_root'
  end

  get 'measurements/selectbox', to: 'measurements#selectbox'
  get 'groceries/selectbox', to: 'groceries#selectbox'

  resources :recipes, only: [:index, :show]
  resources :groceries, only: [:index, :show]

  root 'admins#new'
end
