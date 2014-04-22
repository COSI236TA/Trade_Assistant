TradeAssistant::Application.routes.draw do

  #root
  root to: 'home#index'          

  #iframe request
  # get "iframe/get_portfolio_html"
  get "iframe/get_rule_html"
  get "iframe/get_stock_json"


  #portolio listing request, it can deal with iframe and normal page uniformly
  #it should have two paramters in the url: type and portfoli_id
  #if type is iframe, the page will be rendered in iframe layout
  #if type is page, it will be rendered in normal application layout
  get "/portfolios/get_portfolio" => "portfolios#get_portfolio"

  #users
  post '/settings', :to => 'users#update'
  get '/settings', :to => 'users#edit'

  #session
  get '/login', :to => 'sessions#new'
  get '/register', :to => 'users#new'
  get '/logout', :to => 'sessions#destroy'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'login' => :destroy
  end

  #home
  get "home/about"
  get "home/contact"

  #dashboard
  get "/dashboard" => "dashboard#index"


  match "register" => "users#create", :via => "post", :as => :users
  resources :users, :except => ['create']

  #expose portfolios index
  get "/portfolios" => "portfolios#index"

  
  # resources :portfolios
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


  #AJAX requests
  get "select_portfolio", to: 'rules#select_portfolio'
  get "create_portfolio", to: 'rules#create_portfolio'
  get "ticker_auto_complete", to: 'rules#auto_complete'
  get "portfolio_info",   to: 'portfolios#portfolio_info'
  get "property_info",    to: 'portfolios#property_info'
  get "stock_info",       to: 'stocks#stock_info'

			  


  get "home/index"
  
  #Get IFrame content through ajax
  get "portfolios/get_stock_json", to: 'portfolios#get_stock_json'
  get "portfolios/get_portfolio_html", to: 'portfolios#get_portfolio_html'
  get "rules/get_rule_html", to: 'rules#get_rule_html'
  get "stocks/:sym", to: 'stocks#show_by_sym'
  get "rule_query", to: 'rule_match_result#rule_query' 





  #resources :indicators

  resources :markets

  #Stocks in db would not be accessed directly
  resources :stocks

  resources :rules 

end
