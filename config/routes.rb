Rails.application.routes.draw do
  devise_for :users
  root 'pages#landing'
  get 'home', to: 'pages#home'
  get 'learn_more', to: 'pages#learn_more'

  resources :users, only: [:show] do
    resources :uploads
  end

  resources :events do
    resources :uploads do
      member do
        post 'favorite', to: 'favorites#create'
        delete 'unfavorite', to: 'favorites#destroy'
        post 'generate_caption'
        post 'post_to_social_media'

      end
    end
    resources :messages, only: [:create, :new]
    member do
      get 'qr_code'
      get 'album'
      post 'download_selected'
      get 'guests', to: 'events#guests', as: 'guests_landing_page'
      get :manage_uploads
      get :download_album
    end
  end

  resources :feature_requests, only: [:new, :create, :index]
  resources :favorites, only: [:index, :create, :destroy]

end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
