require 'spec_helper'

describe Mousereco::Pageview do
  describe 'interface' do
    it { should respond_to :combinable? }
    it { should respond_to :start_timestamp }
    it { should respond_to :end_timestamp }
    it { should respond_to :next_pageview }
    it { should respond_to :visit }
  end

  let(:pageview) { described_class.new(timestamp: 123321) }
  let(:event_1) { double(timestamp: 123456) }
  let(:event_2) { double(timestamp: 123458) }
  let(:events) { [event_1, event_2] }

  describe '#combinable?' do
    subject { pageview.combinable?(pageview_combined) }
    let(:pageview_combined) { described_class.new }

    context 'timestamps within overlapping time' do
      before do
        pageview.stub(:end_timestamp) { miliseconds_timestamp_ago(8.minutes) }
        pageview_combined.stub(:start_timestamp) { miliseconds_timestamp_ago(5.minutes) }
      end

      it { should eq true }
    end

    context 'timestamps out of overlapping time' do
      before do
        pageview.stub(:end_timestamp) { miliseconds_timestamp_ago(35.minutes) }
        pageview_combined.stub(:start_timestamp) { miliseconds_timestamp_ago(5.minutes) }
      end

      it { should eq false }
    end

    context 'timestamps overlapping' do
      before do
        pageview.stub(:end_timestamp) { miliseconds_timestamp_ago(5.minutes) }
        pageview_combined.stub(:start_timestamp) { miliseconds_timestamp_ago(6.minutes) }
      end

      it { should eq true }
    end

    context 'timestamps out of overlapping time' do
      before do
        pageview.stub(:end_timestamp) { miliseconds_timestamp_ago(5.minutes) }
        pageview_combined.stub(:start_timestamp) { miliseconds_timestamp_ago(30.minutes) }
      end

      it { should eq false }
    end

    context 'nil in end_timestamp' do
      before do
        pageview.stub(:end_timestamp) { nil }
        pageview_combined.stub(:start_timestamp) { miliseconds_timestamp_ago(5.minutes) }
      end

      it { should eq false }
    end

    context 'nil in start_timestamp' do
      before do
        pageview.stub(:end_timestamp) { miliseconds_timestamp_ago(5.minutes) }
        pageview_combined.stub(:start_timestamp) { nil }
      end

      it { should eq false }
    end
  end

  describe '#start_timestamp' do
    subject { described_class.new(timestamp: 123456).start_timestamp }

    it { should eq 123456 }
  end

  describe '#end_timestamp' do
    subject { pageview.end_timestamp }

    before do
      pageview.stub(:events) { events }
    end

    it { should eq 123458 }

    context 'empty events' do
      let(:events) { [] }
      it { should eq pageview.start_timestamp }
    end
  end

  describe '#next_pageview' do
    subject { pageview_1.next_pageview }
    let(:visit) { Fabricate(:visit) }
    let(:pageview_1) { Fabricate(:pageview_with_events, start_at_timestamp: miliseconds_timestamp_ago(6.minutes), visit: visit) }
    let!(:pageview_2) { Fabricate(:pageview_with_events, start_at_timestamp: miliseconds_timestamp_ago(2.minutes), visit: visit) }

    it { should be_instance_of Mousereco::Pageview }
    it { should eq pageview_2 }

    context 'no next pageview' do
      let(:pageview_1) { Fabricate(:pageview, visit: visit_2) }
      let(:visit_2) { Fabricate(:visit) }
      it { should be_nil }
    end

    context 'no visit' do
      let(:pageview_1) { Fabricate(:pageview) }
      it { should be_nil }
    end
  end

  describe 'pageview_with_events fabricator' do
    subject { pageview }
    let(:pageview) { Fabricate(:pageview_with_events) }
    its(:events) { should_not be_nil }

    it 'events count should be 2' do
      subject.events.count.should eq 2
    end
  end
end