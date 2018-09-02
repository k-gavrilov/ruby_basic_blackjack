class TextInterface
  def choose_option(message, string_arr)
    loop do
      puts message
      threshold = string_arr.size - 1
      puts string_arr
      choice = gets.to_i
      if choice > threshold
        puts "Choose from the listed options!"
        next
      end
      return choice
    end
  end

  def enter_value(message, reg_exp)
    loop do
      puts message
      user_input = gets.chomp
      if user_input !~ reg_exp
        puts "Enter value in requested format!"
        next
      end
      return user_input
    end
  end

  def show_message(message)
    puts message
  end
end
