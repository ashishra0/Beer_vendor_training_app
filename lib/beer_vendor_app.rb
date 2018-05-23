require 'json'
require 'pry'
class BeerVendorApp

  def self.call price_list_json, orders_json, payments_json

    orders_list = JSON.parse(orders_json)
    payments_list = JSON.parse(payments_json)
    prices_list = JSON.parse(price_list_json)
    # binding.pry
    user_orders = []
    orders_list.each do |order|
      # binding.pry
        users = order["user"]
        item = order["drink"] + " " + order["size"]
        user_orders  << {users => item}
    end
      puts user_orders

    price_list = []
    prices_list.each do |price|
        drink_name = price["drink_name"]
        price["prices"].keys.each do |size|
            drink_name += " " + size 
            amount = price["prices"][size]
            price_list << { drink_name => amount}
            drink_name = price["drink_name"]
        end
    end
    puts price_list
		
		result = {}
		user_orders.each do |elem|
			price_list.each do |price|
				# binding.pry
				if elem.keys.first == price.values.first
					if result.has_key?(price.keys.first)
						result[price.keys.first] = result[price.keys.first] + price.values.first
					else
						result.merge!({price.keys.first => elem.values.first})
					end
				end
			end
		end
		puts result     
  end
end
