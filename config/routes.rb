Rails.application.routes.draw do
  get 'messages/create'
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
      get 'album'
      post 'download_selected'
      get 'guests', to: 'events#guests', as: 'guests_landing_page'
      get 'uploads/new', to: 'uploads#new', as: 'new_upload'
      get 'messages/new', to: 'messages#new', as: 'new_message'
      get :manage_uploads
      get :download_album
    end

    resources :events, only: [:create, :show, :destroy]
    post 'download_selected', on: :member
    resources :messages, only: [:create, :index]
  end

  get 'learn_more', to: 'pages#learn_more'
end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
