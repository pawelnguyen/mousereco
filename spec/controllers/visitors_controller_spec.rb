require 'spec_helper'

describe VisitorsController do
  describe '#index' do
    let(:user) { User.create(email:'test@email.com', password: 'password', password_confirmation: 'password')}
    before do
      sign_in user
    end

    subject { get :index; response }

    its(:status) { should eq 200 }
  end
end