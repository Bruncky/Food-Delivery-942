class OrdersView
  def ask_user_for(thing)
    puts "Which #{thing}?"
    print '> '

    gets.chomp
  end

  def display_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name}"
    end
  end

  def display_customers(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name}"
    end
  end

  def display_employees(employees)
    # Here we don't need the index, but the id of the employee
    # since we display only the riders and the index might
    # be different from the actual ID in the database
    employees.each do |employee|
      puts "#{employee.id} - #{employee.username}"
    end
  end

  def display_undelivered(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - Meal: #{order.meal.name} | Customer: #{order.customer.name} | Delivered by: #{order.employee.username} | Delivered: #{order.delivered?}"
    end
  end
end
