describe SeoApp::LinkParser do
  before(:all) do
    FakeWeb.register_uri(:get, 'http://foo.com',
                         body: "<a href='/test_route.html'>Test Message</a>")
  end

  context 'with correct url' do
    subject { SeoApp::LinkParser.new('http://foo.com') }
    let(:report_folder) { SeoApp.root_path.join('public/reports') }

    it 'should generate correct file name' do
      _file_name = 'foo.com__' + subject.time + '.html'

      expect(subject.generate_file_name).to eq(_file_name)
    end

    it 'should generate correct report' do
      allow(subject).to receive(:save_report) { true }

      subject.parse!

      _report = subject.generate_report

      expect(_report).to include('Test Message')
      expect(_report).to include('/test_route.html')
      expect(_report).to include('23.21.224.150')
      expect(_report).to include('United States')
    end

    it 'should save report to correct file' do
      file_path = report_folder.join(subject.generate_file_name)

      mock_handle = double('file handle')
      allow(mock_handle).to receive(:write).with(any_args)
      expect(mock_handle).to receive(:write).once

      allow(File).to receive(:open).and_call_original
      allow(File).to receive(:open).with(file_path, 'w').and_yield(mock_handle)

      subject.save_report
    end
  end

  context 'with nonvalid url' do
    subject { SeoApp::LinkParser.new('bad_url') }

    it 'should return false when called parse! method' do
      expect(subject.parse!).to be false
    end
  end
end
