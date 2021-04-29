Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :areas, only: %i(index adit_all update_all) do
    collection do
      get "edits", to: 'areas/edit', as: :edit
      patch "updates", to: 'areas/update', as: :update
    end
  end
  resources :categories
  resources :posts

end
