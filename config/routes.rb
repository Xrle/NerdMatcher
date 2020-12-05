Rails.application.routes.draw do
  root 'home#index'

  #Home routes
  get 'login' => 'home#login'
  get 'logout' => 'home#logout'

  post 'login' => 'home#auth'

  #User routes
  get 'signup' => 'users#new'

  post 'signup' => 'users#create'

  #Explore routes
  get 'explore' => 'explore#index'
  post 'explore/like' => 'explore#like'
  post 'explore/dislike' => 'explore#dislike'

end