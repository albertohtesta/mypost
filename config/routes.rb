Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    member do
      post 'vote'       # /posts/2/vote y va  post controller, el post es el verbo post, como get, put etc
                        # el verbo POST lo usamos para ser semanticamente correcto ya que se modificaran los datos
                        # por lo que en la vista en el link_to indicamos que vamos a hacer un POST, si no mandara GET y no lo encontrara
    end
    resources :comments, only: [:create] do  # comments solo usa create, ya que su despliegue es atraves de la ruta post y va a comment controller/create
      member do
        post 'vote'
      end
    end
  end
  
  resources :users, only: [:show, :create, :edit, :update]
  resources :categories, only: [:new, :create, :show]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'

end
