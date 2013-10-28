MouseRecorder::Application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
      resources :pageviews, only: [:create] do
        collection do
          post :preflight, to: 'pageviews#preflight'
        end
      end
      match '*all', to: 'application#options', via: [:options]
    end
  end

  resources :visitors, only: [:index]
  resources :pageviews, only: [:show] do
    member do
      get :page_html
    end
  end
  resources :trackers, only: [:show]

  root 'visitors#index'
end
