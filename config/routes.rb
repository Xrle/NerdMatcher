Rails.application.routes.draw do
  root 'home#index'

  #Home routes
  get 'login' => 'home#login'
  post 'login' => 'home#auth'

  get 'logout' => 'home#logout'

  #User routes
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  get 'account' => 'users#edit'
  patch 'account' => 'users#update'
  delete 'account' => 'users#destroy'

  #Explore routes
  get 'explore' => 'explore#index'
  get 'explore/no_users' => 'explore#no_users'

  post 'explore/like' => 'explore#like'
  post 'explore/dislike' => 'explore#dislike'

end