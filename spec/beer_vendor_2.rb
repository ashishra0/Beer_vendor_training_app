require 'json'
# require 'pry'
class BeerVendorApp

  def initialize
    @prices_json = File.read('data/price_list.json')
    @orders_json = File.read('data/orders.json')
    @payments_json = File.read('data/payments.json')
    @prices_json_hash = JSON.parse(@prices_json)
    @orders_json_hash = JSON.parse(@orders_json)    
    @payments_json_hash = JSON.parse(@payments_json)
  end


  def order_total
    bill_one = @payments_json_hash.group_by{|h| h['user']}.map do |k,v|
      {:user => k, :order_total => v.map{|h1| h1['amount']}.first}
    end
  end

  def payment_total
    bill_two = @payments_json_hash.group_by{|h| h['user']}.map do |k,v|
      {:payment_total => v.map{|h2| h2['amount']}.inject(:+)}
    end
    # puts bill_two
  end

  def price_list
    list = Hash.new 0
    @prices_json_hash.each do |key|
        list.store(key['drink_name'], key['prices'])
    end
      puts list.to_json
  end

  def user_drink
    drink = @orders_json_hash.group_by{ |x|[] }
  end

  def bill
    bill = order_total.zip(payment_total)
    puts bill
  end

end

obj = BeerVendorApp.new
obj.payment_total
obj.order_total
obj.bill
obj.price_list