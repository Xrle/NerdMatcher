Rails.application.routes.draw do
  resources :people
  root 'explore#index'
  post 'like', to: 'explore#like'
  post 'dislike', to: 'explore#dislike'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end