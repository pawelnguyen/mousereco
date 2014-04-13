require 'spec_helper'

describe Mousereco::PageviewCombiner do
  describe 'interface' do
    subject { described_class.new(pageviews) }
    let(:pageviews) { [] }
    it { should respond_to :pageviews }
    it { described_class.should respond_to :combine }
  end

  describe '.combine' do
    subject { instance.combine }
    let(:instance) { described_class.new(pageviews) }
    let(:pageviews) { [pageview_1, pageview_2, pageview_3, pageview_4] }
    let(:pageview_1) { double }
    let(:pageview_2) { double }
    let(:pageview_3) { double }
    let(:pageview_4) { double }
    let(:visits) { [visit_1, visit_2] }
    let(:visit_1) { double }
    let(:visit_2) { double }

    it { instance.pageviews.should eq pageviews }
    its(:class) { should eq Array }
    it { should eq visits }
  end
end