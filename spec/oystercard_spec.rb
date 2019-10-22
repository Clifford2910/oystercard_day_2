require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station){ double :station }

  describe '#top_up' do
    it 'increments the balance by the amount passed as argument' do
      expect{ oystercard.top_up(1) }.to change{ oystercard.balance }.by 1
    end

    it 'raises an error when the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      oystercard.top_up(max_balance)
      expect { oystercard.top_up(1) }.to raise_error "Cannot top up, balance will exceed #{max_balance} Pounds"
    end
  end

  describe '#touch_in' do
    it 'puts card in use' do
      oystercard.top_up(5)
      expect{ oystercard.touch_in(station) }.to change { oystercard.in_journey? }.from(false).to(true)
    end

    it 'raises an error when insufficent funds on card' do
      expect { oystercard.touch_in(station) }.to raise_error "Cannot touch in, insufficent funds"
    end

    it 'remembers the entry station after touch in' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'puts card out of use' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect{ oystercard.touch_out }.to change { oystercard.in_journey? }.from(true).to(false)
    end
    it 'minimum fare deducted from card' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect{ oystercard.touch_out }.to change { oystercard.balance }. by -Oystercard::MIN_BALANCE
    end
  end










end
