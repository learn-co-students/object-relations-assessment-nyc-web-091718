require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end
# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

c1 = Customer.new("fname1", "lname1")
c2 = Customer.new("fname2", "lname2")
c3 = Customer.new("fname3", "lname3")
c4 = Customer.new("fname4", "lname4")
c5 = Customer.new("fname4", "lname5")

r1 = Restaurant.new("rest1")
r2 = Restaurant.new("rest2")
r3 = Restaurant.new("rest3")


c1.add_review(r1, 5, "Great")
c2.add_review(r1, 4, "Nice")
c1.add_review(r2, 4, "Nice")
c3.add_review(r1, 5, "Awesome")
c4.add_review(r2, 3, "Fine")
c5.add_review(r3, 1, "bad")

binding.pry
0 #leave this here to ensure binding.pry isn't the last line
