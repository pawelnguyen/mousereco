MouseRecorder::Application.routes.draw do
  mount BaseAPI => '/api'

  root 'home#index'
end
