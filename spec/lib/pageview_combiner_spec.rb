require 'spec_helper'

describe Mousereco::PageviewsCombiner do
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
    let(:pageview_1) { double(combinable?: true) }
    let(:pageview_2) { double(combinable?: false) }
    let(:pageview_3) { double(combinable?: true) }
    let(:pageview_4) { double(combinable?: false) }

    it { instance.pageviews.should eq pageviews }
    its(:class) { should eq Array }
    its(:count) { should eq 2 }

    it 'Visit pageviews' do
      subject.first.pageviews.should eq [pageview_1, pageview_2]
    end
  end
end