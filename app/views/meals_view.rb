class MealsView
  def ask_user_for(thing)
    puts "Which #{thing}?"
    print '> '

    gets.chomp
  end

  def display_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} -> #{meal.name} - #{meal.price}"
    end
  end
end
