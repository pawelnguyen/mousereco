Mousereco::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
      resources :pageviews, only: [:create] do
        collection do
          post :preflight, to: 'pageviews#preflight'
        end
      end
    end
  end

  resources :visitors, only: [:index]

  resources :pageviews, only: [:show] do
    member do
      get :page_html
    end
  end

  resources :trackers, only: [:show]

  root to: 'visitors#index'
end
