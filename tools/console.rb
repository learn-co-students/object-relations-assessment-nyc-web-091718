require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end
# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

# create some sample instances and data here

describe 'Mod1 code challenge' do
  describe Customer do
    before(:all) do
      @ginger = Customer.new('Geri', 'Halliwell')
      @posh = Customer.new('Victoria', 'Beckham')
      @scary = Customer.new('Melanie', 'Brown')
      @sporty = Customer.new('Melanie', 'Chisolm')
      @baby = Customer.new('Emma', 'Bunton')
    end

    describe '.all' do
      it 'should return all of the customer instances' do
        expect(Customer.all).to contain_exactly(@ginger, @posh, @scary, @sporty, @baby)
      end
    end

    describe '.find_by_name' do
      it 'should return the first customer whose full name matches, given a string of a full name' do
        expect(Customer.find_by_name('Melanie Chisolm')).to be(@sporty)
      end
    end

    describe '.find_all_by_first_name' do
      it 'should return an array, given a first name, containing all customers with that first name' do
        expect(Customer.all).to be_an(Array)

        expect(Customer.find_all_by_first_name('Melanie')).to contain_exactly(@scary, @sporty)
      end
    end

    describe '.all_names' do
      it 'should return an array of all of the customer full names' do
        expect(Customer.all_names).to be_an(Array)

        expect(Customer.all_names).to contain_exactly('Melanie Brown', 'Melanie Chisolm', 'Emma Bunton', 'Geri Halliwell', 'Victoria Beckham')
      end
    end

    after(:all) do # or you wind up with more than 5 spice girls in .all by the second test case
      Restaurant::ALL.clear if defined? Restaurant::ALL
      Restaurant.class_variable_set :@@all, []

      Customer::ALL.clear if defined? Customer::ALL
      Customer.class_variable_set :@@all, []

      Review::ALL.clear if defined? Review::ALL
      Review.class_variable_set :@@all, []
    end
  end

  describe Restaurant do
    before(:all) do
      @poesia = Restaurant.new('Poesia')
      @nostalgia = Restaurant.new('Nostalgia')
      @nostalgia_2 = Restaurant.new('Nostalgia')
      @mott = Restaurant.new('Mott')
    end

    describe '.all' do
      it 'should return all of the restaurant instances' do
        expect(Restaurant.all).to be_an(Array)

        expect(Restaurant.all).to contain_exactly(@poesia, @nostalgia, @nostalgia_2, @mott)
      end
    end

    describe '.find_by_name' do
      it 'should return the first restaurant with a name that matches, given a string of a name' do
        expect(Restaurant.find_by_name('Nostalgia')).to be(@nostalgia)
      end
    end

    after(:all) do
      Restaurant::ALL.clear if defined? Restaurant::ALL
      Restaurant.class_variable_set :@@all, []

      Customer::ALL.clear if defined? Customer::ALL
      Customer.class_variable_set :@@all, []

      Review::ALL.clear if defined? Review::ALL
      Review.class_variable_set :@@all, []
    end
  end

  describe Review do
    before(:all) do
      @mpj = Customer.new('Marsha P.', 'Johnson')
      @harvey_milk = Customer.new('Harvey', 'Milk')

      @compton_cafeteria = Restaurant.new("Compton's Cafeteria")
      @stonewall_inn = Restaurant.new('Stonewall Inn')

      @mpj_compton_review = Review.new(@mpj, @compton_cafeteria, 'It was a riot!', 5)
      @mpj_stonewall_review = Review.new(@mpj, @stonewall_inn, 'Got kicked out.', 1)
      @harvey_compton_review = Review.new(@harvey_milk, @compton_cafeteria, 'One cannot live on hope alone, but without it, life is not worth living.', 5)
    end

    describe '.all' do
      it 'should return all of the reviews' do
        expect(Review.all).to be_an(Array)

        expect(Review.all).to contain_exactly(@mpj_compton_review, @harvey_compton_review, @mpj_stonewall_review)
      end
    end

    describe '#customer' do
      it 'should return the customer object for that given review' do
        expect(@mpj_compton_review.customer).to be_an_instance_of(Customer)

        expect(@mpj_compton_review.customer).to be(@mpj)
      end

      it 'should not be mutable after instatiation' do
        expect { @mpj_compton_review.customer = @harvey_milk }.to raise_error(NoMethodError)
      end
    end

    describe '#restaurant' do
      it 'should return the restaurant object for that given review' do
        expect(@mpj_compton_review.restaurant).to be_an_instance_of(Restaurant)

        expect(@mpj_compton_review.restaurant).to be(@compton_cafeteria)
      end

      it 'should not be mutable after instatiation' do
        expect { @mpj_compton_review.restaurant = @stonewall_inn }.to raise_error(NoMethodError)
      end
    end

    describe '#rating' do
      it 'should return the star rating for a restaurant as an integer' do
        expect(@mpj_stonewall_review.rating).to be_an(Integer)

        expect(@mpj_stonewall_review.rating).to eq(1)
      end
    end

    describe '#content' do
      it 'should return the review content as a string' do
        expect(@mpj_stonewall_review.content).to be_a(String)

        expect(@mpj_stonewall_review.content).to eq('Got kicked out.')
      end
    end
  end

  describe 'Aggregate methods' do
    before(:all) do
      @mpj = Customer.new('Marsha P.', 'Johnson')
      @harvey_milk = Customer.new('Harvey', 'Milk')

      @compton_cafeteria = Restaurant.new("Compton's Cafeteria")
      @stonewall_inn = Restaurant.new('Stonewall Inn')
      @chillis = Restaurant.new('Chillis of midtown')
      @dennys = Restaurant.new("Denny's")

      @mpj_compton_review = Review.new(@mpj, @compton_cafeteria, 'It was a riot!', 5)
      @mpj_stonewall_review = Review.new(@mpj, @stonewall_inn, 'Got kicked out.', 1)
      @harvey_compton_review = Review.new(@harvey_milk, @compton_cafeteria, 'One cannot live on hope alone, but without it, life is not worth living.', 5)
      @mpj_chillis_review_1 = Review.new(@mpj, @chillis, 'Why am I eating here?', 1)
      @mpj_chillis_review_2 = Review.new(@mpj, @chillis, 'Wow so depressing', 1)
      @mpj_chillis_review_3 = Review.new(@mpj, @chillis, 'Somehow worse than the first time', 1)
    end

    describe 'Customer aggregate methods' do
      describe '#add_review' do
        it 'should create a review and associate it with a customer and a restaurant, given a restaurant object and a content string' do
          # ugh I don't want to rely on this return value but...
          harvey_dennys_review = @harvey_milk.add_review(@dennys, 'If a bullet should enter my brain, let that bullet destroy every closet door.', 3)
          expect(harvey_dennys_review.instance_variable_get(:@restaurant)).to be(@dennys)
          expect(harvey_dennys_review.instance_variable_get(:@customer)).to be(@harvey_milk)
        end
      end

      describe '#num_reviews' do
        it 'should return the total number of reviews a customer has authored' do
          expect(@harvey_milk.num_reviews).to be_an(Integer)

          expect(@harvey_milk.num_reviews).to eq(2)
        end
      end
    end

    describe '#restaurants' do
      it 'should return a unique list of restaurants that a customer has reviewed' do
        expect(@mpj.restaurants).to be_an(Array)
        expect(@mpj.restaurants).to contain_exactly(@chillis, @stonewall_inn, @compton_cafeteria)
      end
    end

    describe 'Restaurant aggregate methods' do
      describe '#customers' do
        it 'should return all of customers who have written reviews of that restaurant' do
          expect(@chillis.customers).to be_an(Array)
          expect(@chillis.customers).to contain_exactly(@mpj)
        end
      end

      describe '#reviews' do
        it 'should return an array of all reviews for a restaurant object' do
          expect(@chillis.reviews).to be_an(Array)
          expect(@chillis.reviews).to contain_exactly(@mpj_chillis_review_1, @mpj_chillis_review_2, @mpj_chillis_review_3)
        end
      end

      describe '#average_star_rating' do
        it 'should return the average star rating for a restaurant' do
          expect(@compton_cafeteria.average_star_rating).to be_an(Integer)
          expect(@compton_cafeteria.average_star_rating).to eq(5)
        end
      end

      describe '#longest_review' do
        it 'should return the review instance with the longest review' do
          expect(@compton_cafeteria.longest_review).to be_a(Review)
          expect(@compton_cafeteria.longest_review).to be(@harvey_compton_review)
        end
      end
    end
  end

  after(:all) do
    Restaurant::ALL.clear if defined? Restaurant::ALL
    Restaurant.class_variable_set :@@all, []

    Customer::ALL.clear if defined? Customer::ALL
    Customer.class_variable_set :@@all, []

    Review::ALL.clear if defined? Review::ALL
    Review.class_variable_set :@@all, []
  end
end

# binding.pry
0 # leave this here to ensure binding.pry isn't the last line
