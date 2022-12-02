Rails.application.routes.draw do
  namespace :users do
    get '/:token/invitations', to: 'invitations#index', as: :user_invitations
  end

  namespace :admin do
    resources :users, except: :show
    resources :locations, except: [:show, :destroy]
    resources :groups, except: [:show, :destroy]
    resources :training_sessions do
      scope module: "training_sessions" do
        resources :duplicates, only: :create
      end
    end
  end

  resources :training_sessions, only: [:show]
  resources :invitations, only: [:update]
  resources :sessions, only: [:new, :create, :destroy]

  get "/login" => redirect("/sessions/new")

  root to: 'training_sessions#index'

end
