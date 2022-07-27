require_relative '../views/employees_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @employees_view = EmployeesView.new
  end

  def sign_in
    # 1. Ask the user for a username
    username = @employees_view.ask_user_for(:username)
    # 2. Ask the user for a password
    password = @employees_view.ask_user_for(:password)
    # 3. Find the employee by username
    employee = @employee_repository.find_by_username(username)
    
    # 4. Check if username and password match
    if employee && employee.password == password
      # 4a. Display welcome message
      @employees_view.valid_credentials(username)

      employee
    else
      @employees_view.invalid_credentials
      # 5. Sign in
      sign_in   # recursive call!
    end
  end
end
