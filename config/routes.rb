Rails.application.routes.draw do
  resources :jobs, only: [:show, :create]
  resources :sources, except: [:new, :edit]
  # resources :users, except: [:new, :edit]

  mount Knock::Engine => "/knock"
end
