require 'csv'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1

    load_csv if File.exist?(csv_file)
  end

  def create(meal)
    # Create and add meal to @meals
    meal.id = @next_id
    @meals << meal

    # Increment next_id
    @next_id += 1

    # Save to CSV
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << %w[id name price]

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: 1, name: 'chocolate cake', price: 2}
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i

      #                      Meal.new(id: 1, name: 'chocolate cake', price: 2)
      @meals << Meal.new(row)
    end

    @next_id = @meals.last.id + 1 unless @meals.empty?
    # @meals.empty? ? @next_id = 1 : @next_id = @meals.last.id + 1
  end
end
