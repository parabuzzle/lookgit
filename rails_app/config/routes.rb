ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.root :controller => "site"
  map.connect 'repositories', :controller => 'repo', :action => 'index'
  map.connect 'add', :controller => 'repo', :action => 'new'
  map.connect 'user', :controller => 'user', :action => 'index'
  map.connect 'logout', :controller => 'user', :action => 'logout'
  map.connect 'login', :controller => 'user', :action => 'login'
  map.connect 'register', :controller => 'user', :action => 'register'
  map.connect ':username', :controller => 'user', :action => 'profile'
  map.connect ':username/:reponame', :controller => 'repo', :action => 'show'
  map.connect ':username/:reponame/watch', :controller => 'repo', :action => 'watch'
  map.connect ':username/:reponame/unwatch', :controller => 'repo', :action => 'unwatch'
  map.connect ':username/:reponame/commits/:branch/*path', :controller => 'repo', :action => 'commits'
  map.connect ':username/:reponame/tags/:branch/*path', :controller => 'repo', :action => 'tags'
  map.connect ':username/:reponame/:type/:branch' , :controller => 'repo' , :action => 'show'
  map.connect ':username/:reponame/:type/:branch/*path' , :controller => 'repo' , :action => 'show'
  map.connect ':username/:reponame/:type', :controller => 'repo', :action => 'show', :branch => 'master'
  
  #map.connect 'repo/:username/:reponame', :controller => 'repo', :action => 'show'
  map.resources :repo
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect 'profile/:username', :controller => 'user', :action => 'profile'
  
  #map.connect 'user/:id', :controller => 'user', :action => 'show'
  #map.resources :repo
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
end
