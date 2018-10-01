require 'pry'

class Customer
  attr_accessor :first_name, :last_name

  @@all = []

  def self.all
    @@all
  end

  def self.find_by_name(full_name)
    self.all.find do |customer|
      customer if customer.first_name == full_name.split.first &&
      customer.last_name == full_name.split.last
    end
  end

  def self.find_all_by_first_name(f_name)
    self.all.find_all do |customer|
      customer if customer.first_name == f_name.split.first
    end
  end

  def self.all_names
    self.all.map do |customer|
      "#{customer.first_name} #{customer.last_name}"
    end
  end

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    @@all << self
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_review(restaurant, rating, content)
    Review.new(self, restaurant, rating, content)
  end

  def num_reviews
    Review.all.select do |review|
      review.customer == self
    end.count
  end

  def restaurants
    Review.all.select do |review|
      review.restaurant if review.customer == self
    end
  end

end




# - `Customer#restaurants`
#   - Returns a **unique** array of all restaurants a customer has reviewed
