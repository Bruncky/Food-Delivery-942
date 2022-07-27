require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []

    load_csv if File.exist?(csv_file)
  end

  def all_riders
    @employees.select { |employee| employee.role == 'rider' }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: 1, username: 'bruncky', password: 'secret', role: 'manager'}
      row[:id] = row[:id].to_i

      @employees << Employee.new(row)
    end
  end
end
