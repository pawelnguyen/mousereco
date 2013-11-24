require 'spec_helper'

describe WebsitesController do
  let!(:website) { Website.create }
  let(:user) { User.create(email: 'test@email.com', password: 'password', password_confirmation: 'password') }

  describe '#show' do
    subject { get :show, {id: website.id}; response }

    its(:status) { should eq 302 }

    context 'signed in' do
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

  describe '#index' do
    subject { get :index; response }

    its(:status) { should eq 302 }

    context 'signed in' do
      before do
        sign_in user
      end

      its(:status) { should eq 200 }
    end
  end
end