Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup',    to: 'users#new'
  get '/login/',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'delivery_plan', to: 'users#delivery_plan'
    end
  end
  
  resources :bases do
    resources :deliveryinfos
  end
  

end
