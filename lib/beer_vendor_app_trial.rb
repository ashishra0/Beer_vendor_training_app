require 'json'
def beer_vendor
    prices_json = File.read("data/price_list.json")
    orders_json = File.read("data/orders.json")
    payments_json = File.read("data/payments.json")
    prices_json_hash = JSON.parse(prices_json)
    orders_json_hash = JSON.parse(orders_json)
    payments_json_hash = JSON.parse(payments_json)
end

def self.call orders_json, 

    price_list = Hash.new 0
    prices_json_hash.each do |key|
        price_list.store(key['drink_name'], key['prices'])
    end
    puts price_list
     
    beer_order_price = Array.new
    orders_json_hash.each do |order|
         price = price_list.store(order['drink'], order['size'])
         beer_order_price.push(price)
    end

    #   puts beer_order_price

    # each_user_order = Hash.new 0
    # orders_json_hash.each do |name|
    #     each_user_order.store(name['user'], name['drink'])
    # end

    each_user = Hash.new 0
    payments_json_hash.each do |value|
       each_user = {:'user' => value['user']}
    end
    #  puts each_user

    each_user_amount = Hash.new 0
    payments_json_hash.each do |value|
       each_user_amount = {:'order_total' => value['amount']}
    end
    example = each_user.dup
    each_user_amount.each do |k,v|
        example[k] ||= 0
        example[k] += v
    end
    
    #  puts example

    # def user_price
    #     payment = Struct.new(:username, :amount) do
    #         def user
    #             User.where(name :username)
    #         end
    #     end
    # end
    
    # puts payments_json_hash


    



    # each_user_drink_amount = Array.new 0
    # orders_json_hash.each do |value|
    
    # end

    

    # beer_name_order = orders_json_hash.collect { |p| "#{p["drink"]}" }
    # beer_order_size = orders_json_hash.collect { |p|"#{p["size"]}" }
    
    # beer_payments = payments_json_hash.collect { |p| "#{p["user"]} #{p["amount"]}"}

    # # beer rates based on the sizes.
    # beer_small_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["small"]}" if p["prices"]["small"]}
    # beer_medium_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["medium"]}" if p["prices"]["medium"]}
    # beer_large_rates  = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["large"]}" if p["prices"]["large"]}
    # beer_huge_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["huge"]}" if p["prices"]["huge"]}
    # beer_mega_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["mega"]}" if p["prices"]["mega"]}
    # beer_ultra_rates = Proc.new {|p| "#{p['drink_name']} #{p["prices"]["ultra"]}" if p["prices"]["ultra"]}

    # # beer orders based on size of beer
    # small_beer_orders = Proc.new  { |k| k["small"]}
    # medium_beer_orders = Proc.new { |k| k["medium"]}
    # large_beer_orders = Proc.new { |k| k["large"]}
    # huge_beer_orders = Proc.new { |k| k["huge"]}
    # ultra_beer_orders = Proc.new { |k| k["ultra"]}

    #  puts prices_json_hash.collect(&beer_small_rates) - [nil]
    # puts prices_json_hash.collect(&beer_medium_rates) - [nil]
    # puts prices_json_hash.collect(&beer_large_rates) - [nil]
    # puts prices_json_hash.collect(&beer_huge_rates) - [nil]
    # puts prices_json_hash.collect(&beer_mega_rates) - [nil]
    # puts prices_json_hash.collect(&beer_ultra_rates) - [nil]

    # puts all_beer_orders.select(&small_beer_orders)
    # puts all_beer_orders.select(&medium_beer_orders)
    # puts all_beer_orders.select(&large_beer_orders)
    # puts all_beer_orders.select(&huge_beer_orders)
    # puts all_beer_orders.select(&ultra_beer_orders)




# require 'json'
# class BeerVendorApp

#   def self.call orders_json, payments_json, price_list_json
#     orders_json, payments_json, price_list_json = JSON.parse(orders_json), JSON.parse(payments_json), JSON.parse(price_list_json)
#     result = {}
#     orders, menu = {}, {}
#     for x in prices_json
#       for y in x['prices'].keys
#         menu[x['drink_name'] + " " + y]=x['prices'][y]
#       end
#     end
#     for x in orders_json
#         orders[x]=[orders[x],0]
#         for y in payments_json
#             y["user"]==x ? orders[x["user"]]
#   end

    user_orders = []
    orders_json_hash.each do |order|
        users = order["user"]
        item = order["drink"] + " " + order["size"]
        user_orders  << {users => item}
    end
    #  puts user_orders
    puts

    price_list = []
    prices_json_hash.each do |price|
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
				binding.pry
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
beer_vendor
