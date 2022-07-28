class OrdersView
  def ask_user_for(thing)
    puts "Which #{thing}?"
    print '> '

    gets.chomp
  end

  def display_meals(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name}"
    end
  end

  def display_customers(customers)
    customers.each do |customer, index|
      puts "#{customer.id} - #{customer.name}"
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
    orders.each do |order, index|
      puts "#{order.id} - Meal: #{order.meal.name} | Customer: #{order.customer.name} | Delivered by: #{order.employee.username} | Delivered: #{order.delivered?}"
    end
  end
end
