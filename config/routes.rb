Rails.application.routes.draw do
  root to: 'participants#new'

  resources :participants, only: [:new, :create] do
    collection do
      get :ask_for_survey
      post :survey_decision
    end
  end

  resources :surveys, only: [:new, :create] do
    collection do
      get :render_survey_completion
    end
  end
end
