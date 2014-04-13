require 'spec_helper'

describe Mousereco::Pageview do
  describe 'interface' do
    it { should respond_to :combinable? }
  end

  describe '#combinable?' do
    subject { pageview.combinable?(pageview_combined) }
    let(:pageview) { Fabricate.build(:pageview) }
    let(:pageview_combined) { Fabricate.build(:pageview) }

    it { should eq true }
  end
end