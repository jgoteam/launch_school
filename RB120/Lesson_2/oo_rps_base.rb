WHO_WINS = { "paper" => "scissors",
"rock" => "paper",
"scissors" => "rock" }

module Actionable
  def players_go
    player.throw
    comp.throw
  end

  def play_again?
    puts "Play Again?(y/n)"
    choice = gets.chomp
    ['y', 'yes'].include?(choice.downcase) ? true : false
  end
end

module Displayable
  def welcome
    system('clear') || system('cls')
    puts "Let's Play Tic-Tac-Toe!"
  end

  def show_moves
    puts "You chose #{player.hand}. Comp chose #{comp.hand}."
  end

  def who_won
    if WHO_WINS[player.hand] == comp.hand
      comp.name
    elsif WHO_WINS[comp.hand] == player.hand
      player.name
    else
      "No one"
    end
  end

  def show_winner(winner)
    puts "#{winner} won!"
  end

  def goodbye
    puts "Thanks for playing Tic-Tac-Toe. Goodbye!"
  end
end

class RPS_Game
  include Actionable
  include Displayable

  attr_accessor :player, :comp

  def initialize
    @player = Human.new("Player")
    @comp = Comp.new("Comp")
  end

  def play
    loop do
      welcome
      players_go
      show_moves
      show_winner(who_won)
      break unless play_again?
    end
    goodbye
  end
end

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def throw
    action = ""
    loop do
      puts "rock, paper, or scissors?"
      action = gets.chomp
      break if ["rock", "paper", "scissors"].include?(action)
      puts "That's not a valid choice. Please try again."
    end
    @hand = action
  end
end

class Comp < Player
  def throw
    @hand = ["rock", "paper", "scissors"].sample
  end
end

RPS_Game.new.play
