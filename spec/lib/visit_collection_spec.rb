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
    subject { instance.visits }
    let(:instance) { described_class.new }
    let(:visitors) { [double] }
    let(:sorted_visits) { [visit_2, visit_1, visit_3] }
    let(:visit_1) { double }
    let(:visit_2) { double }
    let(:visit_3) { double }

    before do
      visitors.stub_chain(:map, :flatten, :sort, :reverse).and_return(sorted_visits)
    end

    it { should_not be_nil }
    it { should eq sorted_visits }
  end
end