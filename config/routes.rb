ActionController::Routing::Routes.draw do |map|

  map.root :controller => "shirts"

  map.resources :labels
  map.resources :shirts,
    :collection => {:random => :get, :fresh => :get, :da_best => :get},
    :has_many => [:celeb_votes, :comments, :votes]

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
