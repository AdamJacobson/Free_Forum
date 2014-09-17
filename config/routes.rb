FreeForum::Application.routes.draw do
	root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/forum_settings',   to: 'static_pages#forum_settings',   via: 'get'

  resources :users
	match '/signup',  to: 'users#new',            via: 'get'
  match '/users/:id/posts', to: 'users#user_posts', via: 'get', as: 'user_posts'
  match '/users/:id/topics', to: 'users#user_topics', via: 'get', as: 'user_topics'
  
  resources :sessions, only: [:new, :create, :destroy]
 	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  resources :boards, shallow: true do
    resources :topics do
      resources :posts
    end
  end

  resources :ranks
end
