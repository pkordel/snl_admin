Rails.application.routes.draw do

  mount SnlAdmin::Engine => "/snl_admin"

  root to: "dashboard#index"
end
