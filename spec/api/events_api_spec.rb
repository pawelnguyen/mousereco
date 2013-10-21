require 'spec_helper'

describe 'POST /api/v1/events' do
  subject { post "/api/v1/events", data; response }
  let(:data) {
    {"url" => "http://test.com",
     "user_key" => "4k5n245j625k23nrg",
     "pageview_key" => "3kjn234jk23n4tk4her",
     "visitor_key" => "49tuhiarf9q834tn34k3t",
     "events" =>
       {"0" => {"x" => "123.0", "y" => "321.4", "timestamp" => "123456671"},
        "1" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456678", "type" => "onscroll"},
        "2" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456771", "type" => "onscroll"},
        "3" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456872", "type" => "mousemove"},
        "4" => {"x" => "125.0", "y" => "323.4", "timestamp" => "123456973", "type" => "click"}
       }
    }
  }

  its(:status) { should eq 200 }

  it 'saves events' do
    subject
    Visitor.count.should eq 1
    Pageview.count.should eq 1
    visitor = Visitor.last
    visitor.clicks.count.should eq 2
    visitor.mousemoves.count.should eq 1
    visitor.pageviews.count.should eq 1
    visitor.onscrolls.count.should eq 2
    visitor.events.count.should eq data["events"].count
    Pageview.last.events.count.should eq data["events"].count
    Event.count.should eq data["events"].count
  end
end