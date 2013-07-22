FeedbackOverflow::Application.routes.draw do
  root to: 'topics#index'

  resources :topics

  resources :users
  get '/users/:id/topics' => 'users#user_topics', :as => 'user_topics'
  get '/users/:id/comments' => 'users#user_comments', :as => 'user_comments'

  resources :sessions, only: [:create]
  get '/signup' => 'users#new', as: 'signup'
  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#delete'

  resources :comments, only: [:create, :destroy, :edit, :update]


  post '/upvote/new' => 'upvotes#create', :as => 'upvote'

  get '/socratesoauth' => 'oauth#login', :as => 'oauth'
  get '/callback' => 'oauth#callback', :as => 'callback'


  resources :cohorts

  resources :scores, only: [:new, :create]

end
