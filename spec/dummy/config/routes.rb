MouseRecorder::Application.routes.draw do
  mount Mousereco::Engine, at: "/mousereco"

  resource :home, only: [:index]

  root to: 'home#index'
end
