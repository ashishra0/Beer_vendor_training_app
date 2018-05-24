require 'json'
require 'pry'
class BeerVendorApp

  def self.call price_list_json, orders_json, payments_json

    orders_list = JSON.parse(orders_json)
    payments_list = JSON.parse(payments_json)
    prices_list = JSON.parse(price_list_json)
    # binding.pry

    # each users's orders.
    user_orders = []
    orders_list.each do |order|
      # binding.pry
        users = order["user"]
        item = order["drink"] + " " + order["size"]
        user_orders  << {users => item}
    end

    #  price list of each item.
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
    
    # total cost of each user's orders.
    result = {}
		user_orders.each do |elem|
      price_list.each do |price|
        # binding.pry
        if price.keys.first == elem.values.first
          if result.has_key?(elem.keys.first)
						result[elem.keys.first] = result[elem.keys.first] + price.values.first
					else
            result.merge!({elem.keys.first => price.values.first})
					end
        end
			end
    end
    puts result
       
  # total payment by each user.
    payment_list = {}
    payments_list.each do |amt|
        # binding.pry
      if payment_list.has_key?(amt.values.first)
        payment_list[amt.values.first] = amt.values.last + amt.values.last
      else
        payment_list.merge!({amt.values.first => amt.values.last})
      end
    end
    puts payment_list

    # What each user owes
    owes_list = {}
    dues = payment_list.merge result.select {|k| payment_list.keys.include? k }
    owes_list = payment_list.merge(dues) do |k, v1, v2|
      if payment_list.has_key?(k)
        v2-v1
      end
    end
    # binding.pry
    puts owes_list
  end
end
