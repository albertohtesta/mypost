Rails.application.routes.draw do

	root to: "pages#front"
	get 'home', to: "videos#index"
	get 'ui(/:action)', controller: 'ui'
	get 'register', to: "users#new"
	 get "/register/:token", to: "users#new_with_invitation_token", as: :register_with_token
	get 'sign_in', to: 'sessions#new'
	get 'sign_out', to: 'sessions#destroy'

	get 'my_queue', to: 'queue_items#index'
	post 'update_queue', to: 'queue_items#update_queue'
	get 'people', to: 'relationships#index'

	get "forgot_password", to: "forgot_passwords#new"
    resources :forgot_passwords, only: :create
    get "forgot_password_confirmation", to: "forgot_passwords#confirm"
    get "expired_token", to: "forgot_passwords#expired_token"
    resources :password_resets, only: [:create, :show]

	resources :videos, only: [:show] do
		resources :reviews, only: :create
		collection do
			post :search, to: "videos#search"
		end
	end

	resources :users, only: [:create, :show]
	resources :sessions, only: [:create]
	resources :category, only: :show
	resources :queue_items, only: [:create, :destroy]
	resources :relationships, only: [:create,:destroy]
	resources :invitations, only: [:new, :create]

	resources :todos, only: [:index, :new, :create] do
  	collection do
  		get :search, to: "todos#seach"
  	end
  	member do
  		post "highlight", to: "todos#highlight"
  	end
  end

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
