require 'spec_helper'

describe Mousereco::Visit do
  describe 'interface' do
    it { should_not be_nil }
    it { should respond_to :pageviews }
    it { should respond_to :combine }
    it { should respond_to :combinable? }
  end

  describe '#combine' do
    subject { described_class.new.tap { |v| v.combine(pageview) } }
    let(:pageview) { Fabricate.build(:pageview) }
    its(:pageviews) { should include pageview }
  end

  describe '.create_with_pageview' do
    subject { described_class.create_with_pageview(pageview) }
    let(:pageview) { Fabricate.build(:pageview) }

    it { should be_an_instance_of described_class }
    its(:pageviews) { should include pageview }
  end
end