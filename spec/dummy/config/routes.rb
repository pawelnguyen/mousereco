MouseRecorder::Application.routes.draw do
  mount Mousereco::Engine, at: "/mousereco"

  root to: redirect('/mousereco')
end
