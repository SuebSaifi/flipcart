Rails.application.routes.draw do
  devise_for :admins
  devise_for :users,:controllers=>{registrations:"registrations"} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'products#index'
  resources :users do 
  get "wishlist" =>"wishlists#index"
  end
  resources :products,only:[:index,:show] do 
    post "wishlists/toggle"
    delete 'wishlist/:id',  to: 'wishlists#toggle'
      
  end
  resources :categories,only:[:show]
  resources :user_steps
  namespace :admin do
    root to: 'products#index'
    resources :products,only:[:index,:new,:edit,:create,:update,:destroy]
    resources :categories,only:[:index,:new,:edit,:create,:update,:destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
