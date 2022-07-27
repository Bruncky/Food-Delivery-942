class Employee
  attr_reader :username, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]    # manager or driver
  end

  def manager?
    @role == 'manager'
  end

  def driver?
    @role == 'driver'
  end
end
