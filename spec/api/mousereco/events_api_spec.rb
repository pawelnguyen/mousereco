require 'spec_helper'

describe Mousereco::Api::V1::EventsController, type: :controller do
  routes { Mousereco::Engine.routes }

  subject { post "/mousereco/api/v1/events", data; response }
  let(:data) {
    {"url" => "http://test.com",
     "pageview_key" => pageview.key,
     "visitor_key" => pageview.visit.visitor.key,
     "events" =>
       {"0" => {"x" => "123.0", "y" => "321.4", "timestamp" => "123456671"},
        "1" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456678", "type" => "scroll"},
        "2" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456771", "type" => "scroll"},
        "3" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456872", "type" => "mousemove"},
        "4" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456973", "type" => "click"}
       }
    }
  }
  let(:pageview) { Fabricate(:pageview_with_visit) }

  its(:status) { should eq 200 }

  it 'saves events' do
    subject
    Mousereco::Pageview.count.should eq 1
    pageview = Mousereco::Pageview.last
    pageview.clicks.count.should eq 2
    pageview.mousemoves.count.should eq 1
    pageview.scrolls.count.should eq 2
    pageview.events.count.should eq data["events"].count
    Mousereco::Event.count.should eq data["events"].count
  end

  context 'empty events array' do
    let(:data) {
      {"url" => "http://test.com",
       "pageview_key" => pageview.key,
       "visitor_key" => pageview.visitor.key
      }
    }

    it { should be_success}
  end
end