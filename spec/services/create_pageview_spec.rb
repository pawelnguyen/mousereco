require 'spec_helper'

describe Mousereco::CreatePageview do
  describe '#create' do
    subject { described_class.new(attributes).create }

    context 'no previous pageviews existing' do
      let(:attributes) { {visitor_key: 'test_visitor_key', pageview_key: 'test_pageview_key', url: 'http://test.com',
                          page_html: '<html><head></head></html>', window_width: '800', window_height: '600',
                          timestamp: '123456789'} }
      let(:visitor) { double }
      let(:pageview) { double }

      before do
        Mousereco::Visitor.any_instance.should_receive(:add_pageview).and_return true
      end

      it 'creates visitor and pageview' do
        subject
        Mousereco::Visitor.count.should eq 1
        Mousereco::Pageview.count.should eq 1
      end
    end
  end
end