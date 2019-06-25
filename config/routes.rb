Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup',    to: 'users#new'
  get '/login/',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # 顧客情報更新
  patch 'users/:user_id/articles/:id/update', to: 'articles#update', as: :update_articles
  # 顧客情報削除 
  delete 'users/:user_id/articles/:id/destroy', to: 'articles#destroy', as: :delete_articles

  
  
  resources :users do
    # 顧客情報登録
    resources :articles, only: [:create, :index] #リソースをネストしていることで/users/:user_id/articlesというURLになる。
  end

end
