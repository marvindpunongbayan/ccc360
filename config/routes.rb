Ccc360::Application.routes.draw do
  resources :people do
    collection do
      get :search
    end
    member do
      get :impersonate
    end
  end
  resources :personal_forms
  resources :reviews do
    collection do
      post :new_submit_form
      get :new_subject
      post :new_submit_subject
      get :new_initiator
      post :new_submit_initiator
      get :new_details
      get :search
    end
    member do
      post :remind_reviewers
    end
    resources :reviewers do
      collection do
        get :search
      end
      member do
        post :uncomplete
      end
    end
  end
  #match "/reviews/:review_id/reviewers/:id/collate", :to => "reviewers#show", :collate => true, :as => "collate_review_reviewer"
  match "/reviews/:review_id/collate", :to => "reviewers#show", :collate => true, :as => "collate_review"
  match "home", :to => "dashboard#index"
  match "home#new", :to => "reviews#new"
  match "admin", :to => "admin/question_sheets#index"
  match "/review_codes/:code", :to => "reviewers#edit_from_code"
  match "/logout", :to => "dashboard#logout"

  root :to => "dashboard#index"

  namespace :admin do
    resources :question_sheets do
      member do
        post :toggle_personal
      end
    end
  end
end
