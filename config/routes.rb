MouseRecorder::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
      match '*all', to: 'application#options', via: [:options]
    end
  end

  root 'home#index'
end
