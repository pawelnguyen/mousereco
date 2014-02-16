require 'spec_helper'

describe Mousereco::PageviewsController do
  routes { Mousereco::Engine.routes }

  describe '#show' do
    let(:pageview) { Fabricate(:pageview) }
    subject { get :show, {id: pageview.id}; response }

    it_behaves_like :http_authenticated
  end
end