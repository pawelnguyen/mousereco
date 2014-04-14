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

  describe '#sort' do
    subject { [visit_1, visit_2, visit_3].sort }
    let(:visit_1) { described_class.new }
    let(:visit_2) { described_class.new }
    let(:visit_3) { described_class.new }

    before do
      visit_1.stub(:start_timestamp) { nil }
      visit_2.stub(:start_timestamp) { 123456 }
      visit_3.stub(:start_timestamp) { 123406 }
    end

    it { should eq [visit_1, visit_3, visit_2] }
  end
end