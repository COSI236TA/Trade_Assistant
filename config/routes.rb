TradeAssistant::Application.routes.draw do
  root to: 'home#index'          
  
  #get "users/settings"

  #
  post '/settings', :to => 'users#update'
  get '/settings', :to => 'users#edit'
  get '/login', :to => 'sessions#new'
  get '/register', :to => 'users#new'
  get '/logout', :to => 'sessions#destroy'

  get "/dashboard" => "dashboard#index"
  get "home/about"
  get "home/contact"


  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'login' => :destroy
  end

  match "register" => "users#create", :via => "post", :as => :users
  resources :users, :except => ['create']

  #match "users" => "users#index", :via => "get"

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  controller :dashboard do
    get 'dashboard' => :new
  end

  #Create new rule
  get "create_rule", to: 'rules#new'
  post "create_rule", to: 'rules#create'

  get "ticker_auto_complete", to: 'rules#auto_complete'

			  
  get "home/index"
  get "stocks/:sym", to: 'stocks#show_by_sym'
  get "rule_query", to: 'rule_match_result#rule_query' 



  #resources :indicators

  resources :markets

  #Stocks in db would not be accessed directly
  # resources :stocks

  resources :rules 
  #    collection do
   ##   get 'indicator'
  #    end
 # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
