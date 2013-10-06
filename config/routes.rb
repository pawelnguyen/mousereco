MouseRecorder::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
    end
  end

  match '*all' => 'application#options', via: [:options]
  root 'home#index'
end
