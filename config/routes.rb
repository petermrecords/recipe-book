Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins, except: [:show]

  scope :admin do
  	get '/login/', to: 'sessions#new'
  	post '/login/', to: 'sessions#create'
  	delete '/login/', to: 'sessions#destroy'

    put '/recipes/:id/publish', to: 'recipes#publish', as: 'recipe_publish'
    patch '/recipes/:id/publish', to: 'recipes#publish'
    get 'recipes/:id/preview', to: 'recipes#preview', as: 'recipe_preview'
  	resources :recipes, except: [:index, :show] do
      resources :ingredients, except: [:index, :show]
      resources :steps, except: [:index, :show]
    end
    resources :groceries, except: [:index, :show]
    get '/', to: 'recipes#admin', as: 'admin_root'
  end

  get 'measurements/selectbox', to: 'measurements#selectbox'
  get 'groceries/selectbox', to: 'groceries#selectbox'

  resources :recipes, only: [:index, :show]
  resources :groceries, only: [:index, :show]

  root 'admins#new'
end
