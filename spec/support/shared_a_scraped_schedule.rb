shared_examples 'a scraped schedule' do |route, options = {}|
  options[:has_routes] = true if options[:has_routes].nil?
  options[:day] ||= described_class::WEEKDAY
  options[:time] ||= described_class::ALL_DAY

  let(:scraper){ described_class.new(route, day: options[:day], time: options[:time]) }

  context 'with a fetched schedule', vcr: {cassette_name: ['schedule', route, options[:day], options[:time]].compact.join('-') } do
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

    describe 'the response' do
      let!(:response){ scraper.fetch }

      it 'should have a title' do
        response.title.should_not be_nil
      end

      it 'should have stops' do
        response.stops.should_not be_empty
      end

      if options[:has_routes]
        it 'should have routes' do
          response.routes.should_not be_empty
        end

        it 'should have a timetable' do
          response.timetable.should_not be_empty
        end            
      else
        it 'should not have routes' do
          response.routes.should be_empty
        end

        it 'should not have a timetable' do
          response.timetable.should be_empty
        end    
      end
    end
  end
end