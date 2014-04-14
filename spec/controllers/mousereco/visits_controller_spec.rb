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
        let(:visitor) { Fabricate(:visitor) }
        let!(:pageviews) { [pageview_1, pageview_2] }
        let(:pageview_1) { Fabricate(:pageview, visitor: visitor) }
        let(:pageview_2) { Fabricate(:pageview, visitor: visitor) }
        let!(:events_1) { [event_1, event_2] }
        let!(:events_2) { [event_3, event_4] }
        let(:event_1) { Fabricate(:event, timestamp: 123000, pageview: pageview_1) }
        let(:event_2) { Fabricate(:event, timestamp: 123200, pageview: pageview_1) }
        let(:event_3) { Fabricate(:event, timestamp: 123450, pageview: pageview_2) }
        let(:event_4) { Fabricate(:event, timestamp: 123600, pageview: pageview_2) }

        it { should be_success }
        it 'should render proper amount of visits' do
          subject.body.scan(/visit-container/).length.should eq 1
        end
      end
    end
  end
end