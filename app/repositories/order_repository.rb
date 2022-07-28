class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file

    # Auxiliary repos
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @next_id = 1
    @orders = []

    load_csv if File.exist?(csv_file)
  end

  def create(order)
    order.id = @next_id
    @orders << order

    @next_id += 1

    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(current_user)
    # For some reason, the old version we had below didn't work because of &&,
    # so I just called the method above with already gets undelivered orders

    # OLD: undelivered_orders.reject { |order| order.delivered? && order.employee.username != current_user.username }
    undelivered_orders.reject { |order| order.employee.username != current_user.username }
  end

  def mark_as_delivered(order)
    order.deliver!

    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: 1, delivered: true, meal_id: 1, customer_id: 2, employee_id: 3}
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'

      # Finding instances
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)

      #                       Order.new({id: 1, delivered: true, meal: OBJECT, customer: OBJECT, employee: OBJECT})
      @orders << Order.new(row)
    end

    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      # csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      csv << %w[id delivered meal_id customer_id employee_id]

      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
