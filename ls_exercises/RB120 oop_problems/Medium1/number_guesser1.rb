class GuessingGame
  GUESS_LIMIT = 7
  RANGE = 1..100
  private_constant :GUESS_LIMIT, :RANGE

  def initialize
    @num = Random.new.rand(RANGE)
    @guess_counter = GUESS_LIMIT
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

  attr_reader :num
  attr_accessor :guess, :guess_counter

  def get_valid_num
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      self.guess = gets.chomp.to_i
      break if RANGE === guess
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
