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
    let(:visitors) { [visitor] }
    let(:visitor) { double }
    let(:visits) { [visit_1, visit_2, visit_3] }
    let(:visit_1) { double(created_at: Time.current - 2.days) }
    let(:visit_2) { double(created_at: Time.current - 1.days) }
    let(:visit_3) { double(created_at: Time.current - 3.days) }
    let(:sorted_visits) { [visit_2, visit_1, visit_3] }

    before do
      visitor.should_receive(:visits).and_return visits
    end

    it { should_not be_nil }
    it { should eq sorted_visits }
  end
end