require 'spec_helper'

describe Mousereco::Visit do
  describe 'interface' do
    it { should_not be_nil }
    it { should respond_to :start_timestamp }
    it { should respond_to :pageviews }
    it { should respond_to :add_pageview }
  end

  describe '#start_timestamp' do
    subject { described_class.new(pageviews).start_timestamp }
    let(:pageviews) { [pageview_1, pageview_2] }
    let(:pageview_1) { double(start_timestamp: 123456) }
    let(:pageview_2) { double }

    it { should eq 123456 }

    context 'no pageviews' do
      let(:pageviews) { [] }
      it { should be_nil }
    end
  end
end