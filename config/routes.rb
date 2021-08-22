Rails.application.routes.draw do

  get 'users/index'
  # トップページ
  root 'homes#index'

  # 機能紹介
  # get 'about', to: 'homes#about'
  get 'guests_function', to: 'homes#guests_function' # ゲストユーザーの機能
  get 'general_users_function', to: 'homes#general_users_function' # ログインユーザーの機能
  get 'premium_users_function', to: 'homes#premium_users_function' # 有料会員の機能
  get 'about_membership_registration', to: 'homes#about_membership_registration' # 有料会員の登録方法について
  get 'about_membership_withdrawal', to: 'homes#about_membership_withdrawal' # 有料会員の退会方法について
  get 'inquiry', to: 'homes#inquiry' # お問い合わせはこちら
  get 'faq', to: 'homes#faq' # よくある質問

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
      get 'clubs/select'
      post 'clubs/add'
      post 'clubs/add_buttom'
      post 'clubs/take'
      post 'clubs/logical_deletion'
      resources :clubs, except: %i(show destroy)
    end
  end

  # カード情報
  resources :cards do
    collection do
      get 'about', to: 'card/about'
    end
  end

  # ゴルフ場
  resources :golfclubs do
    # ゴルフコース情報
    resources :courses, except: %i(index) do
      # ゴルフホール情報
      resources :holes
    end
    # 攻略情報
    resources :strategy_infos do
      collection do
        # indexページ
        get :hole
        get :main
        get :location
        # 登録編集ページ
        get :registration_edit
        get :switch
      end
      # 管理者削除アクション
      delete :admin_destroy
    end
    # 攻略情報-写真一覧
    resources :strategy_photos, only: %i(index destroy) do
      collection do
        get :course
        get :pagenate
      end
    end
    # 投稿情報
    resources :posts, except: %i(show)
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