Rails.application.routes.draw do

  resources :members
  resources :pages

  root 'welcome#index'
  get "/:page" => "static#show"
end
