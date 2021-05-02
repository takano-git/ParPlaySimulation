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

  resources :admin_pages, only: :index 

  resources :golfclub
  resources :categories
  resources :posts

end
