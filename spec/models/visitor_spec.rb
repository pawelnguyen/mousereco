require 'spec_helper'

describe Mousereco::Visitor do
  describe 'interface' do
    it { should_not be_nil }
    it { should respond_to :visits }
    it { should respond_to :add_pageview }
  end

  describe '#visits' do
    subject { described_class.new.visits }
    it { should_not be_nil }
  end

  describe '#add_pageview' do
    subject { visitor.add_pageview(pageview) }
    let(:visitor) { described_class.new }
    let(:pageview) { Fabricate.build(:pageview) }

    context 'fresh visitor without pageviews and visits' do
      it 'creates visit' do
        subject
        Mousereco::Visit.count.should eq 1
      end
    end

    context 'visitor with a visit' do
      let(:visitor) { described_class.new }
      let(:visits) { [visit] }
      let(:visit) { double }

      before do
        visitor.stub(visits: visits)
        visit.should_receive(:combinable?).and_return(combinable)
      end

      context 'combinable' do
        let(:combinable) { true }
        before { visit.should_receive(:combine).with(pageview).and_return(true) }
        it { should be true }
      end

      context 'non-combinable' do
        let(:combinable) { false }
        before { Mousereco::Visit.should_receive(:create_with_pageview).with(pageview) }
        it { should be true }
      end
    end
  end
end