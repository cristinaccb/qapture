Rails.application.routes.draw do
  devise_for :users
  root 'pages#landing'
  get 'home', to: 'pages#home'

  resources :users, only: [:show] do
    resources :uploads
  end

  resources :events do
    resources :uploads
    member do
      get 'qr_code'
      post 'download_selected'
    end
  end

  get 'learn_more', to: 'pages#learn_more'
end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
