class Review
  attr_reader :customer, :restaurant
  attr_accessor :content, :rating
  @@all = []

  def initialize(customer, restaurant, content, rating)
    @customer = customer
    @restaurant = restaurant
    @content = content
    @rating = rating
    self.class.all << self
  end

  def self.all
    @@all
  end
end
