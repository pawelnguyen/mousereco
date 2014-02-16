require 'spec_helper'

describe Mousereco::VisitorsController do
  routes { Mousereco::Engine.routes }

  describe '#index' do
    subject { get :index; response }

    it_behaves_like :http_authenticated
  end
end