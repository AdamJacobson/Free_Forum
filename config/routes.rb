FreeForum::Application.routes.draw do
	root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'

  resources :users
	match '/signup',  to: 'users#new',            via: 'get'
  
  resources :sessions, only: [:new, :create, :destroy]
 	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  resources :topics, only: [:show, :create, :destroy]

  resources :boards
	match '/boards/:id/new', to: 'topics#new',     via: 'get', as: 'new_topic'
	match '/boards/:id/new', to: 'topics#create',     via: 'post'

end
