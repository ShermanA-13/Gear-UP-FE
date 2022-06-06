require "rails_helper"
RSpec.describe TripService do
  describe "class methods" do
    before do
      data = {
        id: 1,
        attributes: {
          name: "Adventure Time",
          description: "Quite the adventure",
          start_date: "2022-06-08",
          end_date: "2022-06-09"
        }
      }
      trip1 = Trip.new(data)
      expect(trip1).to be_a(Trip)
    end
    it ".get_trip_by_id", :vcr do
      trip_data = TripService.get_trip_by_id(1)

      expect(trip_data).to be_a(Hash)
      expect(trip_data).to have_key(:data)
      expect(trip_data[:data]).to have_key(:id)
      expect(trip_data[:data]).to have_key(:type)
      expect(trip_data[:data]).to have_key(:attributes)
      expect(trip_data[:data][:attributes]).to have_key(:name)
      expect(trip_data[:data][:attributes]).to have_key(:description)
      expect(trip_data[:data][:attributes]).to have_key(:start_date)
      expect(trip_data[:data][:attributes]).to have_key(:end_date)
    end
  end
end
