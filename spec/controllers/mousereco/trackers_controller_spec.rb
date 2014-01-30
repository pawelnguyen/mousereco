require 'spec_helper'

describe Mousereco::TrackersController do
  routes { Mousereco::Engine.routes }

  describe '#show' do
    let(:pageview) { Fabricate(:pageview) }
    subject { get :show, { format: :js, id: 'abc123' }; response }

    its(:status) { should eq 200 }
  end
end