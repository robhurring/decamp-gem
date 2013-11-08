shared_examples 'a scraped schedule' do |route, day, time|
  let(:scraper){ described_class.new(route, day: day, time: time) }

  context '#fetch', vcr: {cassette_name: ['schedule', route, day, time].compact.join('-') } do
    it 'finds the schedule' do
      response = scraper.fetch
      response.should be_ok
    end

    it 'should wrap the response' do
      Decamp.expects(:wrapper_for_route).with(route).returns(Decamp::Response::Generic)
      response = scraper.fetch
      response.should be_kind_of Decamp::Response::Generic
    end
  end
end