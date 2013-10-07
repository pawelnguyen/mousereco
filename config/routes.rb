MouseRecorder::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
      match '*all', to: 'application#options', via: [:options]
    end
  end

  resources :visitors, only: [:index]
  resources :pageviews, only: [:show]
  resources :trackers, only: [:show]

  root 'visitors#index'
end
