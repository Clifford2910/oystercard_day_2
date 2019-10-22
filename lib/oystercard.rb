class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance
  attr_reader :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Cannot top up, balance will exceed #{MAX_BALANCE} Pounds" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    return @in_use
  end

  def touch_in
    raise "Cannot touch in, insufficent funds" if balance < MIN_BALANCE
    @in_use = true
  end

  def touch_out
    deduct_fare(MIN_BALANCE)
    @in_use = false
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end
