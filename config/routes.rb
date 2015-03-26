SnlAdmin::Engine.routes.draw do
  root to: 'dashboard#index'

  get 'dashboard' => 'dashboard#index'
  get 'activities' => 'dashboard#activities'

  resources :users do
    get 'page/:page', action: :index, on: :collection
    member do
      post :reset_statistics
    end
  end

  resources :redirections do
    get 'page/:page', action: :index, on: :collection
  end

  resources :taxonomies do
    get 'page/:page', action: :index, on: :collection
    member do
      get :published_articles
      get :submitted_articles
      get :draft_articles
      get :statistics
    end
  end

  resources :tagsonomies do
    get 'page/:page', action: :index, on: :collection
  end

  resources :revisions, only: [:index, :revert] do
    get 'page/:page', action: :index, on: :collection
    member do
      post :revert
    end
  end

  resources :comments do
    get 'page/:page', action: :index, on: :collection
  end

  resources :deleted_articles, only: [:index, :show, :restore] do
    get 'page/:page', action: :index, on: :collection
    member do
      post :restore
    end
  end
end
