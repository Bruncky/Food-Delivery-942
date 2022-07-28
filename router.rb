class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller

    @running = true
  end

  def run
    @current_user = @sessions_controller.sign_in

    while @running
      # Check current_user's role
      # Print manager menu OR rider menu
      if @current_user.manager?
        print_manager_menu

        choice = gets.chomp.to_i
        print `clear`

        route_manager_action(choice)
      else
        print_rider_menu

        choice = gets.chomp.to_i
        print `clear`

        route_rider_action(choice)
      end
    end
  end

  private

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "8. Exit"
    print "> "
  end

  def print_rider_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. List all customers"
    puts "8. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def route_rider_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @customers_controller.list
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end
