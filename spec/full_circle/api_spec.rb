require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  let!(:api){FullCircle::API.new(FullCircle::Connection.new("360durango.com"))}

  describe "#fetch_events_for_ad" do
    pending "calls the appropriate method on call_api_method" do
      mock_connection = double()
      mock_connection.should_receive(:call_api_method).with("ad.getEvents",{adId: "1"}) do
        class ResponseDouble
          def body
          end
        end
        ResponseDouble.new
      end

      described_class.new(mock_connection).fetch_events_for_ad("1")
    end

    context "with one event" do
      it "returns an array of one event" do
        VCR.use_cassette "single_get_events_response" do
          results = api.fetch_events_for_ad "81213"
          results.should be_a Array
          results
        end
      end

    end
    
    context "with multiple events" do
      it "returns an array of multiple events" do
        VCR.use_cassette "multple_get_events_response" do
          results = api.fetch_events_for_ad "89690"
          results.should be_a Array
          (results.length > 1).should be_true
        end
      end
    end

    context "with no events" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_events_response" do
          results = api.fetch_events_for_ad "1"
          results.should eq []
        end
      end
    end

  end


  describe "#fetch_coupons_for_ad" do

    pending "calls the appropriate method on call_api_method" do
      mock_connection = double()
      mock_connection.should_receive(:call_api_method).with("ad.getCoupons",{adId: "1"})

      described_class.new(mock_connection).fetch_coupons_for_ad("1")
    end
    
    context "with one coupon" do
      it "returns an array of one coupon" do
        VCR.use_cassette "single_get_coupons_response" do
          results = api.fetch_coupons_for_ad "123094"
          results.should be_a Array
          results.length.should eq 1
        end
      end
    end

    context "with multiple coupons" do
      it "returns an array of multiple coupons" do
        VCR.use_cassette "multiple_get_coupons_response" do
          results = api.fetch_coupons_for_ad "82196"
          results.should be_a Array
          results.length.should eq 3
        end
      end
    end

    context "with no coupons" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_coupons_response" do
          results = api.fetch_coupons_for_ad "1"
          results.should eq []
        end
      end
    end
  end

  describe "#fetch_event_areas" do
    pending "calls the appropriate method on call_api_method" do
      mock_connection = double()
      mock_connection.should_receive(:call_api_method).with("city.getEventAreas")

      described_class.new(mock_connection).fetch_event_areas
    end

    context "with one event area" do
      it "returns an array of one event area" do
        VCR.use_cassette "single_event_areas_response" do
          results = api.fetch_event_areas
          results.should be_a Array
          results.length.should eq 1
        end
      end
    end

    context "with multiple event areas" do
      it "returns an array of multiple event areas" do
        VCR.use_cassette "multiple_event_areas_response" do
          results = api.fetch_event_areas
          results.should be_a Array
          results.length.should eq 7
        end
      end
    end

    context "with no event areas" do
      let!(:api){FullCircle::API.new(FullCircle::Connection.new("1019thewave.com"))}
      it "returns an empty array" do
        VCR.use_cassette "empty_event_area_response" do
          results = api.fetch_event_areas
          results.should eq []
        end
      end
    end

  end

  describe "#fetch_upcoming_events" do

    pending "calls the appropriate method on call_api_method" do
      mock_connection = double()
      mock_connection.should_receive(:call_api_method).with("city.getUpcomingEvents",{})

      described_class.new(mock_connection).fetch_upcoming_events
    end

    context "with one event" do
      it "returns an array of one event" do
        VCR.use_cassette "single_get_upcoming_events_response" do
          results = api.fetch_upcoming_events areaId: "592"
          results.should be_a Array
          results.length.should be 1
        end
      end

    end
    
    context "with multiple events" do
      it "returns an array of multiple events" do
        VCR.use_cassette "multiple_get_upcoming_events_response" do
          results = api.fetch_upcoming_events
          results.should be_a Array
          (results.length > 1).should be_true
        end
      end
    end

    context "with no events" do
      let!(:api){FullCircle::API.new(FullCircle::Connection.new("boatersbluepages.com"))}
      it "returns an empty array" do
        VCR.use_cassette "empty_get_upcoming_events_response" do
          results = api.fetch_upcoming_events
          results.should eq []
        end
      end
    end

  end

end
