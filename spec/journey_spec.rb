require 'journey'

describe Journey do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { Journey.new }


  describe "#start" do
    it "remember the entry station" do
      expect(journey.start(entry_station)).to eq(entry_station)
    end
  end

  describe "#finish" do
    it "remembers the exit station" do
      expect(journey.finish(exit_station)).to eq(exit_station)
    end
  end

  describe "#in_journey?" do
    it "returns true if passenger is in journey?" do
      journey.start(entry_station)
      expect(journey.in_journey?).to eq(true)
    end
  end

    it "returns false if passenger not in journey" do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.in_journey?).to eq(false)
    end
  

    describe "#fare_calculator" do
      it "returns minimum fair if in journey" do
        journey.start(entry_station)
        expect(journey.fare).to eq(3)
      end
    end


end
