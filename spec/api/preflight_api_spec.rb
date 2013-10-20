require 'spec_helper'

describe 'POST /api/v1/pages/preflight' do
  subject { post "/api/v1/pages/preflight", data; response }
  let(:data) {
    {"url" => "http://test.com",
     "user_key" => "4k5n245j625k23nrg",
     "pageview_key" => "3kjn234jk23n4tk4her",
     "visitor_key" => "49tuhiarf9q834tn34k3t",
     "timestamp" => "123456671"
    }
  }

  its(:status) { should eq 200 }

  it 'returns success' do
    json_response = JSON.parse(subject.body)
    json_response.keys.should include('success')
  end
end