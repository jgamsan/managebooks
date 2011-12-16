Managebooks::Application.routes.draw do

  get "books/view_daily"
  get "books/update_books"
  get "books/list_books"

  resources :intervals

  resources :identities

  get "welcome/index"

  resources :resorts

  resources :stores

  resources :categories

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
  match 'books/:id/:gd/assign_book' => 'books#assign_book', :as => :assign_book
  #:id para el intervalo, :gd para la fecha
  match 'books/:id/:gd/view_weekly' => 'books#view_weekly', :as => :view_weekly
  # id para el resort :gd para la fecha
  match 'books/:id/:gd/next_day' => 'books#next_day', :as => :next_day
  match 'books/:id/:gd/previous_day' => 'books#previous_day', :as => :previous_day
  match 'books/:id/:gd/next_week' => 'books#next_week', :as => :next_week
  match 'books/:id/:gd/previous_week' => 'books#previous_week', :as => :previous_week
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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
