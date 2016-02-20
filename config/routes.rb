Rails.application.routes.draw do
  resources :members
  resources :pages

  root 'welcome#index'

  match '/auth/:provider/callback' => 'sessions#create', via: [:get]
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:post]
  match '/signin' => 'sessions#new', :as => :signin, via: [:get]
end
