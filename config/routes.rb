Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,:controllers=>{registrations:"registrations"} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'products#index'
  resources :users do 
    get "wishlist" =>"wishlists#index"
    resources :carts do
    # resources :orders
    get "order" =>"orders#new"
    end
  end
  resources :products,only:[:index,:show,:create,:new] do 
    post "wishlists/toggle"
    delete 'wishlist/:id',  to: 'wishlists#toggle'    
  end
  resources :categories,only:[:show]
  resources :user_steps
  resources :checkout,only:[:create]
  post 'checkout/create',to: "checkout#create"
  # post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  # post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  # post 'line_items' => "line_items#create"
  # get 'line_items/:id' => "line_items#show", as: "line_item"
  # delete 'line_items/:id' => "line_items#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
