require_relative '../models/order'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @orders_view = OrdersView.new
  end

  def add
    meal = find_meal
    customer = find_customer
    employee = find_employee

    order = Order.new(meal: meal, customer: customer, employee: employee)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display_undelivered(undelivered_orders)
  end

  def list_my_orders(current_user)
    list_my_undelivered_orders(current_user)
  end

  def mark_as_delivered(current_user)
    list_my_undelivered_orders(current_user)

    order_id = @orders_view.ask_user_for(:order)
    my_orders = @order_repository.my_undelivered_orders(current_user)
    
    order = my_orders[order_id.to_i]

    order.deliver!
    # @order_repository.mark_as_delivered(order)
  end

  private

  def find_meal
    # Get all meals
    meals = @meal_repository.all

    # Show meals to customer
    @orders_view.display_meals(meals)

    meal_id = @orders_view.ask_user_for(:meal_id)

    meals[meal_id.to_i]
    # @meal_repository.find(meal_id)
  end

  def find_customer
    # Get all customers
    customers = @customer_repository.all

    # Show customers to customer
    @orders_view.display_customers(customers)

    customer_id = @orders_view.ask_user_for(:customer_id)

    # customers[customer_id.to_i]
    @customer_repository.find(customer_id)
  end

  def find_employee
    # Get all employees
    employees = @employee_repository.all_riders

    # Show employees to customer
    @orders_view.display_employees(employees)

    employee_id = @orders_view.ask_user_for(:employee_id)

    employees[employee_id.to_i]
    # @employee_repository.find(employee_id)
  end

  def list_my_undelivered_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @orders_view.display_undelivered(orders)
  end
end