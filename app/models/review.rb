class Review
  attr_accessor :rating, :content
  attr_reader :customer, :restaurant

  @@all = []

  def self.all
    @@all
  end

  def initialize(customer, restaurant, rating, content)
    @customer = customer
    @restaurant = restaurant
    @rating = rating
    @content = content
    @@all << self
  end

end

# - `Review#rating`
#   - returns the star rating for a restaurant. This should be an integer from 1-5
