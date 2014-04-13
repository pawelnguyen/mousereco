require 'spec_helper'

describe Mousereco::Visitor do
  describe 'interface' do
    it { should_not be_nil }
    it { should respond_to :visits }
  end

  describe '#visits' do
    subject { described_class.new.visits }
    let(:pageview_combiner) { double }
    let(:visits) { [double] }

    before do
      Mousereco::PageviewsCombiner.should_receive(:new).and_return(pageview_combiner)
      pageview_combiner.should_receive(:combine).and_return(visits)
    end

    it { should eq visits }
  end
end