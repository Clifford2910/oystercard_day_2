class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance
  attr_reader :in_use
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_history

  def initialize
    @balance = 0
    @journey_history = {}
  end

  def top_up(amount)
    raise "Cannot top up, balance will exceed #{MAX_BALANCE} Pounds" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Cannot touch in, insufficent funds" if balance < MIN_BALANCE
    @entry_station = station
    @journey_history[:entry_station] = station
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
    deduct_fare(MIN_BALANCE)
    @journey_history[:exit_station] = station
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end
