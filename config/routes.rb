SnlAdmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :users do
    get 'page/:page', :action => :index, :on => :collection
  end
end
