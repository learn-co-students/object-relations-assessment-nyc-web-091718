class Customer
  attr_accessor :first_name, :last_name
  @@all = []

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name

    @@all << self
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_review(restaurant, content, rating)
    Review.new(self, restaurant, rating, content)
  end

  def reviews
    Review.all.select do |review|
      review.customer == self
    end
  end

  def restaurants
    self.reviews.map do |review|
      review.restaurant
    end
  end

  def num_reviews
    Review.all.count do |review|
      review.customer == self
    end
  end

  ### Class Methods
  def self.all
    @@all
  end

  def self.all_names
    all.map do |customer|
      customer.full_name
    end
  end

  def self.find_by_name(name)
    all.find do |customer|
      customer.full_name == name
    end
  end

  def self.find_all_by_first_name(first_name)
    customers = all.select do |customer|
      customer.first_name == first_name
    end
  end

end ### End of Customer Class

#### Build the following methods on the `Customer` class

# DONE - `Customer#add_review(restaurant, content, rating)`
#   - given a **restaurant object**, some review content (as a string), and a star rating (as an integer), creates a new review and associates it with that customer and restaurant.
#
# DONE - `Customer#num_reviews`
#   - Returns the total number of reviews that a customer has authored
#
# DONE- `Customer#restaurants`
#   - Returns a **unique** array of all restaurants a customer has reviewed


# DONE - `Customer.all`
#   - should return **all** of the customer instances

# DONE - `Customer.find_by_name(name)`
#   - given a string of a **full name**, returns the **first customer** whose full name matches

# DONE - `Customer.find_all_by_first_name(name)`
#   - given a string of a first name, returns an **array** containing all customers with that first name

# DONE - `Customer.all_names`
#   - should return an **array** of all of the customer full names
