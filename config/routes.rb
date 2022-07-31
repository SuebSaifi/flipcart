Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,:controllers=>{registrations:"registrations"} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'products#index'
  resources :users do 
    get "wishlist" =>"wishlists#index"
    # resources :carts 
    # get "order" =>"orders#new"
  end
  resources :charges
  resources :orders
  resources :products,only:[:index,:show,:create,:new] do 
    post "wishlists/toggle",  to: 'wishlists#toggle'
    delete 'wishlist/:id',  to: 'wishlists#toggle' 
  end
  resources :categories,only:[:show]
  resources :user_steps
  resources :checkout,only:[:create]
  post 'checkout/create',to: "checkout#create",:defaults => { :format => 'js' }
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post '/line_items' ,to: "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "webhook",to:"webhooks#create"
end
