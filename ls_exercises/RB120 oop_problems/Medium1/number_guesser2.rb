class GuessingGame
  def initialize(lower, upper)
    bounds_check(lower, upper)
    @range = (lower..upper)
    @num = Random.new.rand(@range)
    @guess_counter = Math.log2(@range.size - 1).to_i + 1
  end

  def play
    loop do
      show_guesses_left
      get_valid_num
      break if won || lost
      check_guess
    end
    display_result
  end

  private

  attr_reader :num, :range
  attr_accessor :guess, :guess_counter

  def bounds_check(lower, upper)
    raise ArgumentError, "Arguments must all be integers." if !(lower.is_a?(Integer) && upper.is_a?(Integer))
  end

  def get_valid_num
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      self.guess = gets.chomp.to_i
      break if range === guess
      print "Invalid guess. "
    end
    self.guess_counter -= 1
  end

  def show_guesses_left
    str = guess_counter == 1 ? "guess" : "guesses"
    puts "You have #{guess_counter} #{str} remaining."
  end

  def check_guess
    high_or_low = guess > num ? "high" : "low"
    puts "Your guess is too #{high_or_low}. "
  end

  def won
    @guess == @num
  end

  def lost
    guess_counter <= 0
  end

  def display_result
    winner_msg = "That's the number!\n\nYou won!"
    loser_msg = "You have no more guesses. You lost!"
    puts won ? winner_msg : loser_msg
  end
end
