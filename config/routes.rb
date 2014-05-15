SnlAdmin::Engine.routes.draw do
  root to: "dashboard#index"
  get 'dashboard' => 'dashboard#index'
  get 'statistics' => 'dashboard#statistics'

  resources :users do
    get 'page/:page', :action => :index, :on => :collection
    member do
      post :reset_statistics
    end
  end

  resources :redirections do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :taxonomies do
    get 'page/:page', :action => :index, :on => :collection
    member do
      get :published_articles
      get :submitted_articles
      get :draft_articles
      get :statistics
    end
  end

  resources :revisions, only: [:index, :revert] do
    get 'page/:page', :action => :index, :on => :collection
    post "revisions/:id/revert" => "revisions#revert", :as => "revert_revision"
  end
end
