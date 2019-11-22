require "oystercard"
require "station"

describe Oystercard do

  subject(:oystercard) { Oystercard.new(5) }
  let(:station) { double :station, name: :Tottenham, zone: 6}
  let(:station2) { double :station2, name: :Mile_end, zone: 2}
  let(:journey) { {entry_station: station, exit_station: station2} }

  describe "#initialize" do
    it 'checks that card has empty list of journeys by defualt' do
      expect(subject.journeys_list).to eq []
    end
  end

  describe "#top_up(money)" do
    it "increases the balance by 5 when top_up(5) is called" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    context "when starting with a balance at full limit" do
      it "should raise an error when topping up more money" do
        card = Oystercard.new(Oystercard::BALANCE_LIMIT)
        message = "Limit of £#{Oystercard::BALANCE_LIMIT} has been exceeded"
        expect { card.top_up(5) }.to raise_error message
      end
    end
  end

  describe "#touch_in(entry_station)" do

    it "raises an error if you are already in transit" do
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to raise_error "You never touched out"
    end

    it "raises an error if you do not have enough money" do
      message = "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card"
      card = Oystercard.new
      expect { card.touch_in(station) }.to raise_error message
    end

    it "checks that balance has been reduced by fare when card touched out" do
      subject.touch_in(station)
      expect {subject.touch_out(station2)}.to change{subject.balance}. by(-3)
    end

  #   it "records the entry station when touched in" do
  #     subject.touch_in(station)
  #     expect(subject.entry_station).to eq station
  #   end
   end

  describe "#touch_out(exit_station)" do

    before do
      subject.touch_in(station)
    end

    it "raises an error if not currently in transit" do
      subject.touch_out(station2)
      expect { subject.touch_out(station2) }.to raise_error "You have not touched in"
    end

    # it "forgets the entry station when touched out" do
    #   subject.touch_out(station2)
    #   expect(subject.entry_station).to eq nil
    # end

    it "checks that one journey created after touching out" do
      subject.touch_out(station2)
      expect(subject.journeys_list).to include journey
    end
  end

  describe "#in_journey?" do
    it "returns true if you are currently in transit" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

end
