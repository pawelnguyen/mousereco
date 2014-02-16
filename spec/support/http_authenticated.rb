shared_examples_for :http_authenticated do
  context 'http not authenticated' do
    its(:status) { should eq 401 }
  end

  context 'http authenticated' do
    before(:each) { http_login }

    its(:status) { should eq 200 }
  end
end
