module TextInterface
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    protected

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

    def show_message(message)
      puts message
    end
  end
end
