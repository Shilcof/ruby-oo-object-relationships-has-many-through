class Waiter

    attr_accessor :name, :yrs_experience
  
    @@all = []
  
    def initialize(name, yrs_experience)
      @name = name
      @yrs_experience = yrs_experience
      @@all << self
    end
  
    def self.all
      @@all
    end

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end 

    def meals
        Meal.all.select do |meal|
          meal.waiter == self #checking for waiter now
        end
    end 

    def best_tipper
        best_tipped_meal = meals.max do |meal_a, meal_b|
          meal_a.tip <=> meal_b.tip
        end.customer
    end 

    def most_frequent_customer
        meals.max_by {|i| meals.count(i)}
    end 

    def meal_of_worst_tip
        best_tipped_meal = meals.max do |meal_a, meal_b|
            meal_b.tip <=> meal_a.tip
        end
    end

    def self.most_exp_tips
        all.max_by{|waiter| waiter.yrs_experience}.average_tips
    end

    def average_tips
        meals.collect{|meal| meal.tip}.sum/meals.size
    end
  
  end 