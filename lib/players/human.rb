module Players
  class Human < Player

    def move(board)
      puts "Please enter a valid move between 1-9:"
      input = gets.strip
      return input
    end
  end
end
