require 'change'

class CashRegister
  attr_accessor :coins

  def coins= (coins = [25,10,5,1])
    if (
      coins.class != Array ||
      coins.map { |coin| coin.class.ancestors.include?(Integer) }.include?(false)
    )
      raise 'Invalid Argument'
    end

    @optimal_change = Hash.new do |optimal_change, amount|
      optimal_change[amount] = get_optimal_change(optimal_change, amount, coins)
    end

    @coins = coins
  end

  alias :initialize :coins=

  def make_change(amount)
    if (
      !amount.class.ancestors.include?(Integer) ||
      amount < 0
    )
      raise 'Invalid Argument'
    end

    return(@optimal_change[amount])
  end

  private

  def get_optimal_change(optimal_change, amount, coins)
    if amount < coins.min
      Change.new(coins)
    elsif coins.include?(amount)
      Change.new(coins).add(amount)
    else
      coins.map do |coin|
        optimal_change[amount - coin].add(coin)
      end.select do |change|
        change.value == amount
      end.min { |a,b| a.count <=> b.count }
    end
  end
end
