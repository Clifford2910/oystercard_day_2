class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance
  attr_reader :in_use
  attr_reader :entry_station

  def initialize
    @balance = 0
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
  end

  def touch_out
    @entry_station = nil
    deduct_fare(MIN_BALANCE)
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end
