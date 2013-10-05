MouseRecorder::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :events, to: 'events#create'
    end
  end

  get '*all' => 'application#options', :constraints => {:method => 'OPTIONS'}

  root 'home#index'
end
