Rails.application.routes.draw do

  # トップページ
  root 'homes#index'

  # 機能紹介
  get 'about', to: 'homes#about'

  # ユーザー
  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    member do
      # ゴルフクラブ情報
      get 'clubs/chart'
      post 'clubs/add'
      resources :clubs, except: %i(show)
    end
  end

  # カード情報
  resources :cards, only: %i(index new create destroy) do
    collection do
      get 'about', to: 'card/about'
    end
  end

  # ゴルフ場
  resources :golfclubs do
    # ゴルフコース情報
    resources :courses, except: %i(index show) do
      # ゴルフホール情報
      resources :holes
    end
    # 攻略情報
    resources :strategy_infos do
      collection do
        get :hole
        get :main
        get :location
        get :form_map
      end
    end
    # 投稿情報
    resources :posts
  end

  # ゴルフ場検索（地域）
  resources :areas, only: %i(index show) do
    collection do
      get "edit", to: 'areas/edit', as: :edit
      patch "update", to: 'areas/update', as: :update
    end
  end

  # 投稿情報のカテゴリー
  resources :categories

end