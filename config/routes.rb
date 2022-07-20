Rails.application.routes.draw do
  devise_for :users,:controllers=>{registrations:"registrations"} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'products#index'
  resources :products
  resources :user_steps
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
