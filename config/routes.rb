Rails.application.routes.draw do
  resources :users
  resources :people
  root 'home#index'

  #Home routes
  get 'login' => 'home#login'
  get 'signup' => 'home#signup'
  post 'login' => 'home#auth'

  #Explore routes
  get 'explore' => 'explore#index'
  post 'explore/like' => 'explore#like'
  post 'explore/dislike' => 'explore#dislike'

end