Ccc360::Application.routes.draw do
  resources :people
  resources :reviews do
    collection do
      post :new_submit_person
      get :new_requester
      post :new_submit_requester
      get :new_customize
    end
  end
  match "dashboard", :to => "dashboard#index"
  match "dashboard#new", :to => "reviews#new"
  match "admin", :to => "admin#index"

  root :to => "dashboard#index"

  namespace :admin do
    resources :question_sheets do
      member do
        post :toggle_personal
      end
    end
  end
end
