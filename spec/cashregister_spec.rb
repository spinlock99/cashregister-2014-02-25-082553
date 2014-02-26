require 'spec_helper'
require 'cashregister'

describe CashRegister do
  subject(:cash_register)  { CashRegister.new }
  let(:argument)           { [10,7,1] }
  let(:bad_argument)       { 'A' }
  let(:bad_array_argument) { [1,2,3,'b'] }

  describe "#new" do
    it "should instantiate" do
      expect { cash_register }.to_not raise_exception
    end

    its(:coins) { should eq([25,10,5,1]) }


    it 'sets the coins when passed an argument' do
      CashRegister.new(argument).coins.should eq([10,7,1])
    end

    it 'throws an error when passed a bad argument' do
      expect { CashRegister.new(bad_argument) }.to raise_exception(/invalid argument/i)
    end

    it 'thows an error when passed a bad array argument' do
      expect { CashRegister.new(bad_array_argument) }.to raise_exception(/invalid argument/i)
    end
  end

  describe ".make_change" do
    it 'takes a positive integer as an argument' do
      expect { cash_register.make_change(25) }.to_not raise_exception
    end

    it 'throws an error on a negative integer argument' do
      expect { cash_register.make_change(-25) }.to raise_exception(/invalid argument/i)
    end

    it 'thows an error on a non-integer argument' do
      expect { cash_register.make_change('b') }.to raise_exception(/invalid argument/i)
    end

    it 'returns a hash' do
      cash_register.make_change(25).should be_a(Hash)
    end

    it 'handles zero' do
      cash_register.make_change(0).should eq({25 => 0, 10 => 0, 5 => 0, 1 => 0})
    end

    it 'handles the base case' do
      cash_register.make_change(25).should eq({25 => 1, 10 => 0, 5 => 0, 1 => 0})
    end

    it 'makes change for the given amount' do
      cash_register.make_change(26).should eq({25 => 1, 10 => 0, 5 => 0, 1 => 1})
    end

    it 'makes change for crazy foreign coins' do
      CashRegister.new([10,7,1]).make_change(14).should eq({10 => 0, 7 => 2, 1 => 0})
    end
  end
end
