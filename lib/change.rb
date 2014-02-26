class Change < Hash
  def initialize(coins)
    if (
      !coins.is_a?(Array) ||
      coins.map { |coin| coin.is_a?(Integer) }.include?(false)
    )
      raise 'Invalid Argument'
    end

    coins.map { |coin| self.merge!({coin => 0}) }
  end

  def add(coin)
    raise 'Invalid Argument' if !self.keys.include?(coin)

    return(self.merge({coin => self[coin] + 1}))
  end

  def count
    return(self.values.reduce(:+))
  end

  def value
    self.map do |coin, number|
      coin * number
    end.reduce(:+)
  end
end
