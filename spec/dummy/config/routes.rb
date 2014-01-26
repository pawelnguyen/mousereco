MouseRecorder::Application.routes.draw do
  mount Mousereco::Engine, at: "/mousereco"

  resources :trackers, only: [:show]

  root to: redirect('/mousereco')
end
