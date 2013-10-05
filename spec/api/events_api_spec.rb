require 'spec_helper'

describe 'POST /api/v1/events' do
  subject { post "/api/v1/events", data; response }
  let(:data) {
    {"url"=>"http://test.com",
     "user_key"=>"4k5n245j625k23nrg",
     "visitor_key"=>"49tuhiarf9q834tn34k3t",
     "events"=>
       {"0"=>{"x"=>"123.0", "y"=>"321.4", "timestamp"=>"123456671"},
        "1"=>{"x"=>"125.0", "y"=>"323.4", "timestamp"=>"123456678"}}}
  }

  its(:status) { should eq 200 }

  it 'saves events' do
    subject
    Event.count.should eq 2
  end
end