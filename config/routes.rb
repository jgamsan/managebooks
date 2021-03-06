Managebooks::Application.routes.draw do

  get "dashboard/index"


  resources :offers

  resources :service_extras

  get "books/view_daily"
  get "books/update_books"
  get "books/list_books"
  get "books/delete_books"
  post 'books/assign_book'

  resources :books
  resources :clients
  resources :stores do
    collection do
      get 'list_available'
    end
  end

  resources :identities

  get "welcome/index"

  resources :resorts

  get "welcome/bycategory"
  get "welcome/bystore"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  #match 'welcome/:id/bycategory' => 'welcome#bycategory', :as => :bycategory
  #match 'books/:id/:gd/assign_book' => 'books#assign_book', :as => :assign_book
  match 'books/:id/:gd/get_book' => 'books#get_book', :as => :get_book
  #:id para el intervalo, :gd para la fecha
  match 'books/:id/:gd/view_weekly' => 'books#view_weekly', :as => :view_weekly
  # id para el resort :gd para la fecha
  match 'books/:id/:gd/change_day' => 'books#change_day', :as => :change_day
  match 'books/:id/:gd/change_week' => 'books#change_week', :as => :change_week
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
  match 'admin/stores/update_town_select/:id' => 'admin/stores#update_town_select'
  match 'admin/books/update_day_selected/:id' => 'admin/books#update_day_selected'
  match 'admin/books/update_interval_select/:id' => 'admin/books#update_interval_select'
  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  namespace :admin do
    devise_for :admins, :controllers => { :sessions => "admin/admins/sessions", :passwords => "admin/admins/passwords", :unlocks => "admin/admins/unlocks" }
    resources :admins
    resources :categories, :service_extras, :business_rules, :photo_galleries
    resources :stores do
      member do
        get 'rules'
        get 'invoice'
        get 'invoice_date'
      end
      resources :bids
    end
    resources :books do
      collection do
        get 'para_hoy'
        get 'tomorrow'
        get 'month'
        get 'range'
      end
    end

    resources :resorts do
      resources :offers
    end
    resources :users
    resources :intervals do
      collection do
        get 'new_by_period'
        post 'by_period'
      end
    end
    root :to => 'dashboard#index'
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

