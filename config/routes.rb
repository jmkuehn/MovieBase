Rails.application.routes.draw do
  resources :members
  resources :pages

  root 'welcome#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/signin' => 'sessions#new', :as => :signin
end
