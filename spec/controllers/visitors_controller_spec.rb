require 'spec_helper'

describe VisitorsController do
  describe '#index' do
    subject { get :index; response }

    its(:status) { should eq 200 }
  end
end