require 'spec_helper'

describe Mousereco::VisitorsController do
  routes { Mousereco::Engine.routes }

  describe '#index' do
    subject { get :index; response }

    its(:status) { should eq 200 }
  end
end