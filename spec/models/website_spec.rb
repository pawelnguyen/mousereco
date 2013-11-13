require 'spec_helper'

describe Website do
  subject { described_class.new }
  its(:key) { should_not be_blank }
end
