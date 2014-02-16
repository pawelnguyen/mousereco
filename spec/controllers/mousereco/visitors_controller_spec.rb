require 'spec_helper'

describe Mousereco::VisitorsController do
  routes { Mousereco::Engine.routes }

  describe '#index' do
    subject { get :index; response }

    it_behaves_like :http_authenticated

    context 'authenticated' do
      render_views

      before(:each) { http_login }
      let!(:visitor_1) { Fabricate(:visitor) }
      let!(:visitor_2) { Fabricate(:visitor) }

      its(:body) { should include(visitor_1.key) }
    end
  end
end