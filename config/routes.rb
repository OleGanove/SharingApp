Rails.application.routes.draw do
  devise_for :users 
  resources :users, only: [:show]
  resources :thumbnails, only: [:new]
  resources :posts, except: [:show] do
    member do 
      post 'upvote'
      post 'fupvote'
    end
  end

  authenticated :user do 
    root "posts#index"
  end

  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/datenschutz',   to: 'static_pages#datenschutz'
  get '/contact', to: 'static_pages#contact'
  get '/impressum', to: 'static_pages#impressum'
  get '*path' => redirect('/')
end
