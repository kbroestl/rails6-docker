Rails.application.routes.draw do
  resources :articles
  resources :topics
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'messages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "messages#index"
end
