MouseRecorder::Application.routes.draw do
  mount Mousereco::Engine, at: "/mousereco"

  resource :home, only: [:index]
  get 'subpage', to: 'home#subpage'

  root to: 'home#index'
end
