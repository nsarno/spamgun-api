Rails.application.routes.draw do
  post 'login', to: 'login#create'

  resources :jobs, only: [:show, :create]
  resources :sources, except: [:new, :edit]
  # resources :users, except: [:new, :edit]
end
