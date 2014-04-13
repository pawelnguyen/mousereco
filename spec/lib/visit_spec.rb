require 'spec_helper'

describe Mousereco::Visit do
  describe 'interface' do
    it { should_not be_nil }
    it { should respond_to :created_at }
    it { should respond_to :pageviews }
    it { should respond_to :add_pageview }
  end
end