class Oystercard

  attr_reader :balance, :entry_station, :journeys_list

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3


  def initialize(balance = DEFAULT_BALANCE, journey = Journey.new )
    @balance = balance
    @journeys_list = []
    @journey = journey
  end

  def top_up(money)
    raise "Limit of £#{BALANCE_LIMIT} has been exceeded" if limit_reached?
    @balance += money
  end

  def touch_in(entry_station)
    raise "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card" if insufficient_funds?
    raise "You never touched out" if in_journey?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    raise "You have not touched in" if @journey.journey
    deduct(FARE)
    @journeys_list << {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  private

  def limit_reached?
    @balance >= BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  # def in_journey?
  #   @entry_station != nil
  # end

  def deduct(money)
    @balance -= money
  end

end
