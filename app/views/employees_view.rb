class EmployeesView
  def ask_user_for(thing)
    puts "Which #{thing}?"
    print '> '

    gets.chomp
  end

  def valid_credentials(username)
    puts "You have been signed in. Welcome, #{username}!"
  end

  def invalid_credentials
    puts 'Invalid credentials, try again!'
  end
end
