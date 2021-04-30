Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :areas, only: %i(index) do
    collection do
      get "edit", to: 'areas/edit', as: :edit
      patch "update", to: 'areas/update', as: :update
    end
  end
  resources :categories
  resources :posts

end
