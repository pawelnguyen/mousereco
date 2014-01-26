require 'spec_helper'

describe Mousereco::PageviewsController do
  routes { Mousereco::Engine.routes }

  describe '#show' do
    let(:pageview) { Fabricate(:pageview) }
    subject { get :show, {id: pageview.id}; response }

    its(:status) { should eq 200 }
  end
end