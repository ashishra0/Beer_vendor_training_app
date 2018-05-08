require 'json'

class BeerVendorApp

    prices_json = File.read('data/price_list.json')
    orders_json = File.read('data/orders.json')
    payments_json = File.read('data/payments.json')

    prices_json_hash = JSON.parse(prices_json)
    orders_json_hash = JSON.parse(orders_json)    
    payments_json_hash = JSON.parse(payments_json)

  def self.call prices_json, orders_json, payments_json
    
  end

  def each_user_total_cost
    beer_price = prices_json_hash.collect {|p| "#{p['prices']}" }
    beer_order = orders_json_hash.collect {|o| "#{o['size']} #{o['drink']}"}
  end

end
