require 'spec_helper'

describe PageviewsController do
  describe '#show' do
    let(:website) { Website.create }
    let(:pageview) { Pageview.create(website: website) }
    subject { get :show, {id: pageview.id}; response }

    its(:status) { should eq 302 }

    context 'signed in' do
      let(:user) { User.create(email: 'test@email.com', password: 'password', password_confirmation: 'password') }

      before do
        sign_in user
      end

      it 'should raise cancan error' do
        expect { subject }.to raise_error CanCan::AccessDenied
      end

      context 'website belongs to user' do
        let(:website) { Website.create(user_id: user.id) }

        its(:status) { should eq 200 }
      end
    end
  end
end