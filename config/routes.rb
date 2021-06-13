Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    resources :posts
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
      end
    end
  end

  resources :areas, only: %i(index) do
    collection do
      get "edit", to: 'areas/edit', as: :edit
      patch "update", to: 'areas/update', as: :update
    end
  end
  resources :areas, only: :show

  resources :categories
