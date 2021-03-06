FarsiTextcaptcha::Application.routes.draw do
  constraints :subdomain => 'api', :format => :xml do
    # Routing for API requests
    get "/:api_key" => "questions#api_get", format: :xml, as: "api_get"
    # ...
  end

  get '/sessions/new' => "sessions#new", as: "new_session"
  post '/sessions' => "sessions#create", as: "sessions"
  delete '/session' => "sessions#destroy", as: "session"

  resources :api_key_resets, only: :create
  resources :users, except: [:new, :create]
  resources :answers
  resources :questions do
    get 'unapproved' => "questions#unapproved", on: :collection
    put "approve/:id" => "questions#approve", on: :collection, as: "approve"
  end

  root to: "static_pages#home"
  get "/really" => "static_pages#really"
  get "/why" => "static_pages#why"
  get "/demo" => "static_pages#demo"
  get "/how_it_works" => "static_pages#how_it_works"
  get "/api" => "static_pages#api"
  get "/register" => "users#new", as: "new_user"
  post "/register" => "users#create", as: "users"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
