class Review
  attr_reader :customer, :restaurant
  attr_accessor :content, :rating
  @@all = []

  def initialize(customer, restaurant, rating, content)
    @customer = customer
    @restaurant = restaurant
    @rating = rating
    @content = content

    @@all << self
  end

  def customer
      @customer
  end

  def restaurant
      @restaurant
  end

  def rating
    @rating
  end

  def content
    @content
  end
  ### Class Methods
  def self.all
    @@all
  end

end ### End of Review Class

#### Build out the following methods on the `Review` class

# -DONE `Review.all`
#   - returns all of the reviews
#
# DONE- `Review#customer`
#   - returns the customer object for that given review
#   - Once a review is created, I should not be able to change the author
#
#DONE - `Review#restaurant`
#   - returns the restaurant object for that given review
#   - Once a review is created, I should not be able to change the restaurant
#
# DONE - `Review#rating`
#   - returns the star rating for a restaurant. This should be an integer from 1-5
#
#DONE - `Review#content`
#   - returns the review content, as a string, for a particular review
