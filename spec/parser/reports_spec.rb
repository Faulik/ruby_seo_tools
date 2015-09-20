describe SeoApp do
  context 'with reports folder' do
    it 'should retrieve all reports' do
      _files = ['fodojo.com__2015.20.09_18-18-49.html',
                'google.com__2010.20.09_12-12-12.html']

      _expected = [{ site_url: 'fodojo.com',
                     date: '2015.20.09 18-18-49',
                     file_name: 'fodojo.com__2015.20.09_18-18-49.html' },
                   { site_url: 'google.com',
                     date: '2010.20.09 12-12-12',
                     file_name: 'google.com__2010.20.09_12-12-12.html'
                   }]

      allow(Dir).to receive(:foreach).and_yield(_files[0]).and_yield(_files[1])

      expect(SeoApp.check_reports('/any')).to eq(_expected)
    end
  end
end
