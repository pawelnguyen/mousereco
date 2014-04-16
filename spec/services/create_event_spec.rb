require 'spec_helper'

describe Mousereco::CreateEvent do
  describe '#create' do
    subject { described_class.new(event_params, pageview_key).create }
    let(:event_params) { {x: '1', y: '2', timestamp: '123123', type: 'click'} }
    let(:pageview_key) { pageview.key }
    let(:pageview) { Fabricate(:pageview) }

    it 'creates event' do
      subject
      Mousereco::Event.count.should eq 1
    end
  end
end