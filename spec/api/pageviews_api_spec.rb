require 'spec_helper'

describe Api::V1::PageviewsController do
  describe '#preflight' do
    subject { post "/api/v1/pageviews/preflight", data; response }
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
      json_response.keys.should include('send_html')
    end
  end

  describe '#create' do
    subject { post "/api/v1/pageviews", data; response }
    let(:data) {
      {"url" => "http://test.com",
       "user_key" => "4k5n245j625k23nrg",
       "pageview_key" => "3kjn234jk23n4tk4her",
       "visitor_key" => "49tuhiarf9q834tn34k3t",
       "timestamp" => "123456671",
       "page_html" => "<html><head>..."
      }
    }

    its(:status) { should eq 200 }

    it 'returns success' do
      json_response = JSON.parse(subject.body)
      json_response.keys.should include('success')
    end

    it 'creates pageview' do
      subject
      Pageview.count.should eq 1
      Pageview.last.page_html.should eq data["page_html"]
    end
  end
end