require 'spec_helper'
require 'change'

describe Change do
  let(:good_argument) { [25,10,5,1] }
  let(:bad_argument) { 'a' }
  let(:bad_array_argument) { [25,10,5,1,'a'] }

  describe '#new' do
    it 'expects an array of integers as an argument' do
      expect { Change.new(good_argument) }.to_not raise_exception
    end

    it 'throws an error with no argument' do
      expect { Change.new }.to raise_exception
    end

    it 'throws an error with a bad argument' do
      expect { Change.new(bad_argument) }.to raise_exception(/invalid argument/i)
    end

    it 'throws an error with a bad array argument' do
      expect { Change.new(bad_array_argument) }.to raise_exception(/invalid argument/i)
    end

    it 'is a Hash representing a group of coins' do
      Change.new(good_argument).should eq({25 => 0, 10 => 0, 5 => 0, 1 => 0})
    end
  end

  describe '.add' do
    let(:pile_of_change) { Change.new(good_argument) }

    it 'expects a positive integer argument' do
      expect { pile_of_change.add(25) }.to_not raise_exception
    end

    it 'throws an error is the coin is not a key' do
      expect { pile_of_change.add(9) }.to raise_exception(/invalid argument/i)
      expect { pile_of_change.add('p') }.to raise_exception(/invalid argument/i)
    end
  end

  describe '.count' do
    subject(:change) { Change.new(good_argument) }

    its(:count) { should eq(0) }

    specify { change.add(25).count.should eq(1) }
  end

  describe '.value' do
    subject(:change) { Change.new(good_argument) }

    its(:value) { should eq(0) }

    specify { expect(change.add(25).value).to eq(25) }
  end
end
