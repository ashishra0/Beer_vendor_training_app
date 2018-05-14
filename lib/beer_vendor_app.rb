require 'json'

class BeerVendorApp
  def initialize
      @prices_json = File.read('data/price_list.json')
      @orders_json = File.read('data/orders.json')
      @payments_json = File.read('data/payments.json')
      @prices_json_hash = JSON.parse(@prices_json)
      @orders_json_hash = JSON.parse(@orders_json)    
      @payments_json_hash = JSON.parse(@payments_json)
      @each_user_price = {}
  end

  def self.call prices_json, orders_json, payments_json
    
  end

  def each_user_amount
    @payments_json_hash.group_by {|val| val['user']}.map do |user,array|[user, array.map{|price| price['amount']}.inject(:+)]
    end
    .to_h
  end

  def order_total
    @payments_json_hash.map do |val|
      "order_total: #{val['amount']}"
    end
  end

end

Bill = BeerVendorApp.new
puts Bill.each_user_amount.to_json
puts Bill.order_total
