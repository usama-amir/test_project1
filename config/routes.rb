Rails.application.routes.draw do
  resources :users
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except:[:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get '/auth/google_oauth2' => 'sessions#omniauth'

end
