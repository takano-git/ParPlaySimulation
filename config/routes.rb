Rails.application.routes.draw do

  get 'admin_pages/index'
  root 'homes#index'

  devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :cards
  # resources :card, only: [:new, :create] do
  #   collection do
  #     post 'show', to: 'card/show',
  #     post 'pay', to: 'card/pay',
  #     post 'delete', to: 'card/delete'
  #   end
  # end

  resources :admin_pages, only: :index 

  resources :golfclubs do
    resources :courses do
      resources :holes
    end
  end
  # resources :courses
  # resources :holes
  resources :areas, only: %i(index) do
    collection do
      get "edit", to: 'areas/edit', as: :edit
      patch "update", to: 'areas/update', as: :update
    end
  end
  
  resources :categories
  resources :posts

end
