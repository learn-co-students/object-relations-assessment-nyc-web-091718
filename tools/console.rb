require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end
# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

c1 = Customer.new("Mike", "C")
c2 = Customer.new("Elbin", "K")
c3 = Customer.new("Zach", "V")

r1 = Restaurant.new("Chipotle")
r2 = Restaurant.new("Subway")
r3 = Restaurant.new("Wendys")

rev1 = Review.new(c1, r1, 5, "Great Food")
rev2 = Review.new(c2, r2, 2, "Poor Food")
rev3 = Review.new(c3, r3, 3, "Mediocre Food")
rev4 = Review.new(c3, r2, 3, "This is the longest review ever")


binding.pry
0 #leave this here to ensure binding.pry isn't the last line
