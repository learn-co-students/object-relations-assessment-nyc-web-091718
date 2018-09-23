class Restaurant
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name

    @@all << self
  end

  def reviews
    Review.all.select do |review|
      review.restaurant == self
    end
  end

  def customers
    cust_array = self.reviews.map do |review|
      review.customer
    end
    cust_array.uniq
  end

  def num_reviews
    Review.all.count do |review|
      review.restaurant == self
    end
  end

  def average_star_rating
    total = 0

    self.reviews.each do |review|
      review_rating = review.rating
      total += review_rating
    end
    total / self.num_reviews
  end

  def longest_review
    reviews = self.reviews.map do |review|
      review.content
    end
    reviews.max
  end

  ### Class Methods
  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find do |restaurant|
      restaurant.name == name
    end
  end
end ### End of Restaurant Class


#### Build out the following methods on the `Restaurant` class
# DONE - `Restaurant#customers`
#   - Returns a **unique** list of all customers who have reviewed a particular restaurant.
#
# DONE - `Restaurant#reviews`
#   - returns an array of all reviews for that restaurant
#
# DONE - `Restaurant#average_star_rating`
#   - returns the average star rating for a restaurant based on its reviews
#
# DONE - `Restaurant#longest_review`
#   - returns the longest review content for a given restaurant

# DONE- `Restaurant.all`
#   - returns an array of all restaurants

# DONE - `Restaurant.find_by_name(name)`
#   - given a string of restaurant name, returns the first restaurant that matches
