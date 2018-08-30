SnlAdmin::Engine.routes.draw do
  root to: 'dashboard#index'

  get 'dashboard' => 'dashboard#index'
  get 'activities' => 'dashboard#activities'

  resources :organizations do
    resources :users do
      get 'page/:page', action: :index, on: :collection
      member do
        post :reset_statistics
      end
    end
  end
end
