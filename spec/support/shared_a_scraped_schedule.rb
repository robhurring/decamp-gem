shared_examples 'a scraped schedule' do |route, options = {}|
  options[:day] ||= described_class::WEEKDAY
  options[:time] ||= described_class::ALL_DAY

  around(:each) do |example|
    VCR.use_cassette(['schedule', route, options[:day], options[:time]].compact.join('-'), &example)
  end

  let(:scraper){ described_class.new(route, day: options[:day], time: options[:time]) }

  context 'with a fetched schedule' do
    describe 'fetching' do
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

    describe 'the basic response' do
      let!(:response){ scraper.fetch }

      it 'should have a title' do
        response.title.should_not be_nil
      end

      it 'should have stops' do
        response.stops.should_not be_empty
      end
    end
  end
end

shared_examples 'a schedule with routes' do |route, options = {}|
  it_should_behave_like "a scraped schedule", route, options do
    describe 'the timetable' do
      let!(:response){ scraper.fetch }

      it 'should have routes' do
        response.routes.should_not be_empty
      end

      it 'should have a timetable' do
        response.timetable.should_not be_empty
      end            
    end
  end
end

shared_examples 'a schedule with no routes' do |route, options = {}|
  it_should_behave_like "a scraped schedule", route, options do
    describe 'the timetable' do
      let!(:response){ scraper.fetch }

      it 'should have routes' do
        response.routes.should be_empty
      end

      it 'should have a timetable' do
        response.timetable.should be_empty
      end            
    end
  end
end

