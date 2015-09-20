describe SeoApp::Application do
  def app
    @app ||= SeoApp::Application
  end

  context 'index route' do
    it 'should return valid page' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include 'Enter url:'
    end

    it 'should show error message' do
      get '/?error=NonValidURL'

      expect(last_response).to be_ok
      expect(last_response.body).to include 'error with message: NonValidURL'
    end
  end

  context 'links route' do
    it 'should redirect to /' do
      allow_any_instance_of(SeoApp::LinkParser).to receive(:parse!) { true }

      post '/links', URI.encode_www_form(url: 'http://foo.com')

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end

    it 'should redirect to /?error=NonValidURL' do
      allow_any_instance_of(SeoApp::LinkParser).to receive(:parse!) { false }

      post '/links', URI.encode_www_form(url: 'bad_url')

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.params['error']).to eq('NonValidURL')
      expect(last_response.body).to include 'error with message: NonValidURL'
    end
  end
end
