Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}
  resources :users, only: [:show]
  resources :thumbnails, only: [:new]
  resources :posts, except: [:show] do
    member do 
      post 'upvote'
      post 'fupvote'
    end
  end

  get 'posts/fview' => 'posts#fview'
  get 'posts/view'  => 'posts#view'

  authenticated :user do 
    root "posts#index"
  end

  root 'static_pages#home'
  get '/about',    to: 'static_pages#about'
  get '/datenschutz',   to: 'static_pages#datenschutz'
  get '/nutzung', to: 'static_pages#nutzung'
  get '/impressum', to: 'static_pages#impressum'
  #get '*path' => redirect('/')
end
