Reporting::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }

  resources :tickets, :except => ["new"] do
    match "/reopen" => "tickets#reopen", :via => "post", :as => "reopen"
    match "/close" => "tickets#close", :via => "post", :as => "close"

    resources :tracks, :only => ["create"]
  end

  resources :topics, :except => ["new", "show", "edit"]
  resources :subscribes, :only => ["create", "destroy"]

  #routes for subscribing topics
  get 'tickets/topics/:id' => "subscribes#topicShow", :as => "ticket_topic"
  get 'tickets/query/:query' => "tickets#query", :as => "ticket_query"

  #get resource for autocomplete
  get "/getUsers" => "autocomplete#getUsers"
  get "/getTopics" => "autocomplete#getTopics"
  get "/getTags" => "autocomplete#getTags"

  namespace :admin do
  	root :to => 'tickets#index'
  	resources :tickets
    resources :users, :only => ["index", "new", "create", "destroy"]
    
  end

  root :to => "tickets#index"

end