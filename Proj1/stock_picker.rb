# Returns the days with the greatest difference, retaining order
class StockOption

  attr_accessor :buy_index, :sell_index, :profit

  def initialize(buy_index, sell_index, profit)
    @buy_index = buy_index
    @sell_index = sell_index
    @profit = profit
  end

end

module Commerce
  
  module_function
  
  def stock_picker(prices)
    options = get_options(prices)
    recommendations = find_most_profitable(options)
    
    recommendations.each do |option|
      puts "Buy at #{prices[option.buy_index]} on day #{option.buy_index+1}, sell at #{prices[option.sell_index]}  on day #{option.sell_index+1}, for a whopping #{option.profit} profit"
    end
    
    return recommendations
  end

  def get_options(prices)
    options = []

    prices.each_with_index do |buy_price, buy_index|
      sell_prices = prices[(buy_index+1)..-1]
      sell_prices.each_with_index do |sell_price, sell_index|
        options << StockOption.new(buy_index, sell_index+buy_index+1, (sell_price - buy_price))
      end
    end
    
    return options
  end

  def find_most_profitable(options)
    profits = options.map {|option| option.profit}
    return options.select {|option| option.profit == profits.max }
  end
  
end

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
Commerce.stock_picker(p)
