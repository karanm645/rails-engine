Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      namespace :revenue do 
        resources :merchants, only: [:index, :show]
        resources :items, only: :index 
      end 
      get 'items/find_all', to: 'items#find_all'
      get 'merchants/find', to: 'merchants#find'
      get 'merchants/most_items', to: 'merchants#most_items'
      resources :merchants, only: [:index, :show] do 
        resources :items, module: 'merchants', only: [:index]
      end 
      resources :items, only: [:index, :show, :create, :destroy, :update] do 
        resources :merchant, module: 'items', only: [:index]
      end 
    end 
  end 
end
