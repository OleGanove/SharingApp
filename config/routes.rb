Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :thumbnails, only: [:new]
  resources :posts

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/impressum', to: 'static_pages#impressum'
  get '*path' => redirect('/')
end
