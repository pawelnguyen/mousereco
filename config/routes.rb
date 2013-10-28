MouseRecorder::Application.routes.draw do
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

  devise_for :users

  resources :visitors, only: [:index]

  resources :pageviews, only: [:show] do
    member do
      get :page_html
    end
  end

  resources :trackers, only: [:show]

  root 'home#index'
end
