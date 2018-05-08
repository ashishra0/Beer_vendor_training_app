require 'json'

def beer_vendor
    prices_json = File.read('data/price_list.json')
    orders_json = File.read('data/orders.json')
    payments_json = File.read('data/payments.json')

    prices_json_hash = JSON.parse(prices_json)
    orders_json_hash = JSON.parse(orders_json)
    payments_json_hash = JSON.parse(payments_json)

    all_beer_orders = orders_json_hash.collect { |p| "#{p["user"]} #{p["drink"]} #{p["size"]}" }
    beer_order_size = orders_json_hash.collect { |p|"#{p["size"]}" }
    

    beer_payments = payments_json_hash.collect { |p| "#{p["user"]} #{p["amount"]}"}

    # beer rates based on the sizes.
    beer_small_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["small"]}"}
    beer_medium_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["medium"]}"}
    beer_large_rates  = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["large"]}"}
    beer_huge_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["huge"]}"}
    beer_mega_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["mega"]}"}
    beer_ultra_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["ultra"]}"}

    # beer orders based on size of beer
    small_beer_orders = Proc.new  { |k| k["small"]}
    medium_beer_orders = Proc.new { |k| k["medium"]}
    large_beer_orders = Proc.new { |k| k["large"]}
    huge_beer_orders = Proc.new { |k| k["huge"]}
    ultra_beer_orders = Proc.new { |k| k["ultra"]}

    # puts prices_json_hash.collect(&beer_small_rates)
    # puts prices_json_hash.collect(&beer_medium_rates)
    # puts prices_json_hash.collect(&beer_large_rates)
    # puts prices_json_hash.collect(&beer_huge_rates)
    # puts prices_json_hash.collect(&beer_mega_rates)
    # puts prices_json_hash.collect(&beer_ultra_rates)

    # puts all_beer_orders.select(&small_beer_orders)
    # puts all_beer_orders.select(&medium_beer_orders)
    # puts all_beer_orders.select(&large_beer_orders)
    # puts all_beer_orders.select(&huge_beer_orders)
    # puts all_beer_orders.select(&ultra_beer_orders)

    # puts beer_payments.
    

    

end

beer_vendor