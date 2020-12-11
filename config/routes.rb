Rails.application.routes.draw do
  root 'home#index'

  #Endpoint for resizing uploaded images
  mount ImageUploader.derivation_endpoint => 'derivations'

  #Home routes
  get 'login' => 'home#login'
  post 'login' => 'home#auth'

  get 'logout' => 'home#logout'

  #User routes
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  get 'profile' => 'users#edit'
  patch 'profile' => 'users#update'
  delete 'profile' => 'users#destroy'

  #Explore routes
  get 'explore' => 'explore#index'
  get 'explore/no_users' => 'explore#no_users'

  post 'explore/like' => 'explore#like'
  post 'explore/dislike' => 'explore#dislike'

  #Photo routes
  get 'profile/photos' => 'photos#index'
  get 'profile/photos/upload' => 'photos#new'

  post 'profile/photos/upload' => 'photos#create'

  delete 'profile/photos' => 'photos#destroy'

end