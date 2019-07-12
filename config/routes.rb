Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup',    to: 'users#new'
  get '/login/',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # 顧客情報更新
  # patch 'users/:user_id/articles/:id/update', to: 'articles#update', as: :update_articles
  # # 顧客情報削除 
  # delete 'users/:user_id/articles/:id/destroy', to: 'articles#destroy', as: :delete_articles
  # 配送計画作成ページ
  get 'users/:user_id/articles/delivery_plan', to: 'articles#delivery_plan', as: :delivery_plan
  # 配送計画作成
  patch 'users/:user_id/articles/plan_create', to: 'articles#plan_create', as: :plan_patch
  # 配送計画リスト
  get 'users/:user_id/articles/plan_list', to: 'articles#plan_list', as: :plan_list
  
  
  resources :users do
    # 顧客情報登録
    resources :articles #リソースをネストしていることで/users/:user_id/articlesというURLになる。
  end

end
