class Restaurant
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def reviews
    Review.all.select { |review| review.restaurant == self }
  end

  def customers
    reviews.map(&:customer).uniq
  end

  def average_star_rating
    reviews.map(&:rating).reduce(:+) / reviews.length
  end

  def longest_review
    reviews.max_by { |review| review.content.length }
  end

  def self.find_by_name(name)
    all.find { |rest| rest.name == name }
  end

  def self.all
    @@all
  end
end
