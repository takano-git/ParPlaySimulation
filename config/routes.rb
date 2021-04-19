Rails.application.routes.draw do
  devise_for :users
  get 'homes/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#index'
  resources :posts
end
