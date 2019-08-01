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
  # get 'users/:user_id/articles/delivery_plan', to: 'articles#delivery_plan', as: :delivery_plan
  # 配送計画作成
  # patch 'users/:user_id/articles/plan_create', to: 'articles#plan_create', as: :plan_create
  # 配送計画リスト
  # get 'users/:user_id/articles/plan_list', to: 'articles#plan_list', as: :plan_list
  # 拠点情報登録ページ
  # get 'users/:user_id/articles/base_new', to: 'articles#base_new', as: :base_new
  # 拠点情報作成
  # post 'users/:user_id/articles/base_create', to: 'articles#base_create', as: :base_create
  # 拠点情報確認ページ
  # get 'users/:user_id/articles/base_info', to: 'articles#base_info', as: :base_info
  # 拠点情報編集ページ
  # get 'users/:user_id/articles/base_edit', to: 'articles#base_edit', as: :base_edit
  # 拠点情報更新
  # patch  'users/:user_id/articles/base_update', to: 'articles#base_update', as: :base_update
  # 納品開始・終了時間新規保存
  # post 'users/:user_id/articles/plan_list', to: 'daily_reports#delivery_time', as: :delivery_time
  # 日報一覧
  get 'users/:user_id/daily_reports', to: 'daily_reports#daily_index', as: :daily_index
  
  resources :users do
    # 顧客情報登録
    resources :articles do  #リソースをネストしていることで/users/:user_id/articlesというURLになる。
      collection do
        # 配送計画作成
        get 'delivery_plan', to: 'articles#delivery_plan'
        # 配送計画作成
        patch 'plan_create', to: 'articles#plan_create'
        # 配送計画リスト
        get 'plan_list', to: 'articles#plan_list'
        # 拠点情報登録ページ
        get 'base_new', to: 'articles#base_new'
        # 拠点情報作成
        post 'base_create', to: 'articles#base_create'
        # 拠点情報確認ページ
        get 'base_info', to: 'articles#base_info'
        # 拠点情報編集ページ
        get 'base_edit', to: 'articles#base_edit'
        # 拠点情報更新
        patch 'base_update', to: 'articles#base_update'
        # 納品開始・終了時間新規保存
        post 'plan_list', to: 'daily_reports#delivery_time', as: :delivery_time
      end
    end
  end

end
