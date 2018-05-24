require 'json'
require 'pry'

class UserRepository
  class DuplicateUserError < StandardError; end
  @user_repo = []

  def self.add(username)
    user = find(username)
    if user
      raise(DuplicateUserError, 'user already exist')
    else
      user = User.new(name: username)
      @user_repo << user
    end
    user
  end

  def self.find_or_create(username)
    find(username) || add(username)
  end

  def self.find(username)
    @user_repo.detect { |user| user.name == username }
  end

  def self.all
    @user_repo
  end
end

class User
  attr_reader :name

  def initialize(name:)
    @name = name
  end
end

class Drink
  attr_reader :name

  def initialize(name:)
    @name = name
    @prices = []
  end

  def set_price(price)
    @prices << price
  end
end

class Price
  attr_reader :category, :value

  def initialize(category:, value:)
    @category = category
    @value = value
  end
end

class OrderRepository
  @order_repo = []

  def self.add(username:, drinkname:, size:)
    user = find(username: username, drinkname: drinkname, size: size)
    if user
      raise(DuplicateUserError, 'user already exist')
    else
      user = User.new(name: username)
      @order_repo << user
    end
    user
  end

  def self.find_or_create(username:, drinkname:, size:)
    find(username: username, drinkname: drinkname, size: size) || add(username: username, drinkname: drinkname, size: size)
  end

  def self.find(username:, drinkname:, size:)
    @order_repo.detect { |user| order.username == username }
  end

  def self.all
    @order_repo
  end
end

class Order
  attr_reader :username, :drinkname

  def initialize(username:, drinkname:, size:)
    @username = username
    @drinkname = drinkname
    @size = size
  end

  def user
    UserRepository.find(username)
  end
end

class Payment
  attr_reader :user, :amount

  def initialize(user:, amount:)
    @user = user
    @amount = amount
  end
end

class BeerVendorApp
  def self.call price_list_json, orders_json, payments_json
    price_list = JSON.parse(price_list_json)
    order_list = JSON.parse(orders_json)
    payment_list = JSON.parse(payments_json)
    
    drinks = price_list.map do |price_detail|
      drink = Drink.new(name: price_detail['drink_name'])
      price_detail['prices'].each do |category, value|
         drink.set_price(Price.new(category: category, value: value))
      end
      drink
    end

    orders = order_list.map do |order_detail|
      user = UserRepository.find_or_create(order_detail['user'])
      drink = Drink.new(name: order_detail['drink'])
      size = order_detail['size']
      OrderRepository.add(username: order_details['user'], drinkname: order_detail['drink'], size: order_detail['size'])
    end

    payments = payment_list.map do |payment_detail|
      user = UserRepository.find_or_create(payment_detail['user'])
      Payment.new(user: user, amount: payment_detail['amount'])
    end

    statements = UserRepository.all.map do |user|
      get_statement(user)
    end
    binding.pry
  end

  def self.get_statement(user)
    { user: user.name }
  end
end
