SnlAdmin::Engine.routes.draw do
  root to: "dashboard#index"
  resources :users
end
