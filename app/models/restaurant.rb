class Restaurant
  attr_accessor :name

  @@all = []

  def self.all
    @@all
  end

  def self.find_by_name(rest_name)
    self.all.find do |rest|
      rest if rest.name == rest_name
    end
  end

  def initialize(name)
    @name = name
    @@all << self
  end

end
