require 'spec_helper'

describe Mousereco::VisitCollection do
  before do
    Mousereco::Visitor.should_receive(:all).and_return visitors
  end

  describe 'interface' do
    let(:visitors) { [] }
    it { should_not be_nil }
    it { should respond_to :visits }
    it { should respond_to :visitors }
  end

  describe '#visits' do
    subject { described_class.new.visits }
    let(:visitors) { [visitor] }
    let(:visitor) { double }
    let(:visits) { [visit_1, visit_2] }
    let(:visit_1) { double }
    let(:visit_2) { double }

    before do
      visitor.should_receive(:visits).and_return visits
    end

    it { should_not be_nil }

    #TODO: sort visits
  end
end