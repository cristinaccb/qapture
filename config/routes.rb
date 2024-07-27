Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :uploads
  end

  resources :events do
    resources :uploads
    resource :qr_code, only: [:show, :create]
  end

  # Set the root route to the landing action in PagesController
  root to: 'pages#landing'

  # Route for Learn More page
  get 'learn_more', to: 'pages#learn_more'
end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
