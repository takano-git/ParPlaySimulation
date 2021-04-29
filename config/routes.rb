Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :areas, except: %i(show)
  resources :categories
  resources :posts

end
