SnlAdmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :users do
    get 'page/:page', :action => :index, :on => :collection
    member do
      post :reset_statistics
    end
  end

  resources :redirections do
    get 'page/:page', :action => :index, :on => :collection
  end
end
