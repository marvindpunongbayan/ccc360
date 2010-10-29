Ccc360::Application.routes.draw do
  resources :people
  resources :reviews do
    collection do
      post :new_submit_form
      get :new_subject
      post :new_submit_subject
      get :new_initiator
      post :new_submit_initiator
      get :new_details
    end
    resources :reviewers
  end
  match "dashboard", :to => "dashboard#index"
  match "dashboard#new", :to => "reviews#new"
  match "admin", :to => "admin/question_sheets#index"

  root :to => "dashboard#index"

  namespace :admin do
    resources :question_sheets do
      member do
        post :toggle_personal
      end
    end
  end
end
