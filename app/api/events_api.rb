class EventsApi < Grape::API
  version 'v1', using: :path

  #params do
  #  requires :auth_token, type: String, desc: 'auth_token'
  #  requires :id, type: Integer, desc: 'id of calendar'
  #end

  namespace :events do
    post '/events' do
      #binding.pry
    end
  end
end