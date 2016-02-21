Rails.application.routes.draw do
  get 'statuses/watched'

  get 'statuses/unwatched'

  resources :members
  resources :pages
  resources :movies

  get 'movies_search' => 'movies#search'
  post 'unwatched_movie' => 'movies#unwatched'
  post 'watched_movie' => 'movies#watched'

  root 'welcome#index'

  match '/auth/:provider/callback' => 'sessions#create', via: [:get]
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:post]
  match '/signin' => 'sessions#new', :as => :signin, via: [:get]
end
