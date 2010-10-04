Ccc360::Application.routes.draw do
  resources :people
  resources :reviews
  match "dashboard", :to => "dashboard#index"
  match "admin", :to => "admin#index"

  root :to => "dashboard#index"
end
