require 'json'

task :default => [:run]

desc "load price_list, orders and payments and pass it to app"
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'beer_vendor_app'

  price_list_json = File.read("data/price_list.json")
  orders_json = File.read("data/orders.json")
  payments_json = File.read("data/payments.json")

  result_json = BeerVendorApp.call(prices_json, orders_json, payments_json)

  user_balances = JSON.load(result_json)

  puts "Total:"
  puts sprintf("%-10s%-11s%-11s%-11s", "user", "orders", "payments", "balance")
  puts sprintf("--------")
  user_balances.each do |user_balance|
    puts sprintf("%-10s$%-10.2f$%-10.2f$%-10.2f", user_balance["user"], user_balance["order_total"], user_balance["payment_total"], user_balance["balance"])
  end
end
