require 'spec_helper'

describe Mousereco::Pageview do
  describe 'interface' do
    it { should respond_to :combinable? }
    it { should respond_to :start_timestamp }
    it { should respond_to :end_timestamp }
  end

  let(:pageview) { described_class.new }
  let(:event_1) { double(timestamp: 123456) }
  let(:event_2) { double(timestamp: 123458) }
  let(:events) { [event_1, event_2] }

  describe '#combinable?' do
    subject { pageview.combinable?(pageview_combined) }
    let(:pageview_combined) { described_class.new }

    context 'timestamps within overlapping time' do
      before do
        pageview.stub(:end_timestamp) { 123456 }
        pageview_combined.stub(:start_timestamp) { 123466 }
      end

      it { should eq true }
    end

    context 'timestamps out of overlapping time' do
      before do
        pageview.stub(:end_timestamp) { 123456 }
        pageview_combined.stub(:start_timestamp) { 133456 }
      end

      it { should eq false }
    end

    context 'timestamps overlapping' do
      before do
        pageview.stub(:end_timestamp) { 123456 }
        pageview_combined.stub(:start_timestamp) { 123446 }
      end

      it { should eq true }
    end

    context 'nils' do
      before do
        pageview.stub(:end_timestamp) { nil }
        pageview_combined.stub(:start_timestamp) { 123446 }
      end

      it { should eq false }
    end
  end

  describe '#start_timestamp' do
    subject { pageview.start_timestamp }

    before do
      pageview.stub(:events) { events }
    end

    it { should eq 123456 }

    context 'empty events' do
      let(:events) { [] }
      it { should be_nil }
    end
  end

  describe '#end_timestamp' do
    subject { pageview.end_timestamp }

    before do
      pageview.stub(:events) { events }
    end

    it { should eq 123458 }

    context 'empty events' do
      let(:events) { [] }
      it { should be_nil }
    end
  end
end