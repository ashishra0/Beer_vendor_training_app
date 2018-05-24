require 'spec_helper'
require 'beer_vendor_app'

describe "integration" do
  let(:price_list_json) {
    <<-JSON
      [
        { "drink_name": "Kingfisher", "prices": { "small": 60 } },
        { "drink_name": "Heineken", "prices": { "small": 55, "medium": 100, "large": 140 } },
        { "drink_name": "Corona", "prices": { "small": 30, "medium": 60, "large": 100 } },
        { "drink_name": "Foster", "prices": { "small": 40, "medium": 80 } },
        { "drink_name": "Kalyani Black Label", "prices": { "small": 45, "medium": 90, "large": 130 } },
        { "drink_name": "Carlsberg", "prices": { "large": 150, "huge": 200, "mega": 250, "ultra": 300 } }
      ]
    JSON
  }

  let(:orders_json) {
    <<-JSON
      [
        { "user": "Jon Snow", "drink": "Kingfisher", "size": "small" },
        { "user": "Arya Stark", "drink": "Heineken", "size": "small" },
        { "user": "Tyrion Lannister", "drink": "Kalyani Black Label", "size": "large" },
        { "user": "Khal Drogo", "drink": "Carlsberg", "size": "huge" },
        { "user": "Joffrey Baratheon", "drink": "Foster", "size": "medium" },
        { "user": "Tyrion Lannister", "drink": "Carlsberg", "size": "ultra" }
      ]
    JSON
  }

  let(:payments_json) {
    <<-JSON
      [
        { "user": "Jon Snow", "amount": 40 },
        { "user": "Arya Stark", "amount": 55 },
        { "user": "Khal Drogo", "amount": 250 },
        { "user": "Jon Snow", "amount": 40 }
      ]
    JSON
  }

  let(:expected_result_json) {
    <<-JSON
      [
        { "user": "Jon Snow",          "order_total": 40.00, "payment_total": 80.00, "balance": -40.00 },
        { "user": "Arya Stark",        "order_total": 55.00, "payment_total": 55.00, "balance": 0.00 },
        { "user": "Tyrion Lannister",  "order_total": 450.00, "payment_total": 0.00, "balance": 450.00 },
        { "user": "Khal Drogo",        "order_total": 200.00, "payment_total": 250.00, "balance": -50.00 },
        { "user": "Joffrey Baratheon", "order_total": 80.00, "payment_total": 0.00, "balance": 80.00 }
      ]
    JSON
  }

  before do
    result_json = BeerVendorApp.call(price_list_json, orders_json, payments_json)
    @result = JSON.load(result_json)
  end

  describe BeerVendorApp do
    it "outputs JSON in expected form" do
      expect(@result).to eq JSON.load(expected_result_json)
    end

    it "has all users who have ordered beer" do
      puts 'Pending implementation....'
    end

    it "has order totals for each user" do
      puts 'Pending implementation....'
    end

    it "has payment totals for each user" do
      puts 'Pending implementation....'
    end

    it "has current balance for each user" do
      puts 'Pending implementation....'
    end
  end

end
