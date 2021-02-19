Rails.application.routes.draw do
  root 'users#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login'
  post '/login', to: 'users#validateLogin'
  get '/registered', to: 'users#registered'
  get '/admin', to: 'admin#index'
  

  resources :users
end
