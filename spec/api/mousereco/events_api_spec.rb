require 'spec_helper'

describe Mousereco::Api::V1::EventsController, type: :controller do
  routes { Mousereco::Engine.routes }

  subject { post "/mousereco/api/v1/events", data; response }
  let(:data) {
    {"url" => "http://test.com",
     "pageview_key" => pageview.key,
     "visitor_key" => pageview.visitor.key,
     "events" =>
       {"0" => {"x" => "123.0", "y" => "321.4", "timestamp" => "123456671"},
        "1" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456678", "type" => "scroll"},
        "2" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456771", "type" => "scroll"},
        "3" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456872", "type" => "mousemove"},
        "4" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456973", "type" => "click"}
       }
    }
  }
  let(:pageview) { Fabricate(:pageview) }

  its(:status) { should eq 200 }

  it 'saves events' do
    subject
    Mousereco::Visitor.count.should eq 1
    Mousereco::Pageview.count.should eq 1
    visitor = Mousereco::Visitor.last
    visitor.clicks.count.should eq 2
    visitor.mousemoves.count.should eq 1
    visitor.pageviews.count.should eq 1
    visitor.scrolls.count.should eq 2
    visitor.events.count.should eq data["events"].count
    Mousereco::Pageview.last.events.count.should eq data["events"].count
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