Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    member do
      get 'clubs/chart'
      post 'clubs/add'
      resources :clubs, except: %i(show)
    end
  end

  resources :cards, only: %i(index new create destroy) do
    collection do
      get 'about', to: 'card/about'
    end
  end

  resources :golfclubs do
    resources :courses, except: %i(index show) do
      resources :holes
    end
    resources :strategy_infos do
      collection do
        get :hole
        get :main
        get :location
        get :form_map
      end
    end
    resources :posts
  end

  resources :areas, only: %i(index show) do
    collection do
      get "edit", to: 'areas/edit', as: :edit
      patch "update", to: 'areas/update', as: :update
    end
  end

  resources :categories

end