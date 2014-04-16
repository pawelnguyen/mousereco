require 'spec_helper'

describe Mousereco::VisitsController do
  routes { Mousereco::Engine.routes }

  describe '#index' do
    subject { get :index; response }

    it_behaves_like :http_authenticated

    context 'authenticated' do
      render_views

      before(:each) { http_login }

      it { should be_success }

      context 'visits in database' do
        let(:visit_1) { Fabricate(:visit) }
        let(:visit_2) { Fabricate(:visit) }
        let!(:pageviews) { [pageview_1, pageview_2, pageview_3, pageview_4] }
        let(:pageview_1) { Fabricate(:pageview, visit: visit_1) }
        let(:pageview_2) { Fabricate(:pageview, visit: visit_1) }
        let(:pageview_3) { Fabricate(:pageview, visit: visit_2) }
        let(:pageview_4) { Fabricate(:pageview, visit: visit_2) }

        it { should be_success }
        it 'should render proper amount of visits' do
          subject.body.scan(/visit-container/).length.should eq 2
          subject.body.scan(/\/mousereco\/pageviews\//).length.should eq 4
        end
      end
    end
  end
end