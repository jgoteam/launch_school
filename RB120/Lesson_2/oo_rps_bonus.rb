require 'io/console'

module Displayable
  WIDTH = 65

  def text_chopper(text)
    all_chars = text.chars
    (0..all_chars.size - 1).step(WIDTH - 8) do |limit| # -8 for padding
      limit.downto(0) do |idx|
        if all_chars[idx] == ' '
          all_chars.insert(idx, "\n")
          break
        end
      end
    end
    all_chars.join.split("\n")
  end

  def box_top
    puts '+' + '-' * (WIDTH - 2) + '+'
    puts '|' + ' ' * (WIDTH - 2) + '|'
  end

  def box_bottom
    puts '|' + ' ' * (WIDTH - 2) + '|'
    puts '+' + '-' * (WIDTH - 2) + '+'
    puts
  end

  def box_middle(text)
    lines = (text.size / WIDTH).ceil + 2 # +1 to account for padding
    chopped = text_chopper(text)
    lines.times { |idx| puts "|#{chopped[idx].to_s.center(WIDTH - 2)}|" }
  end

  def box_print(text)
    box_top
    box_middle(text)
    box_bottom
  end
end

class Engine
  include Displayable

  def start
    core_menu
    again? until user_quits
  end

  def self.stop
    puts "Thanks for playing. Goodbye!"
    exit
  end

  private

  attr_accessor :choice

  def show_core_choices
    puts "Press (1) to play RPSSL"
    puts "Press (2) to play traditional RPS"
    puts "Press (3) to select Trial mode (RPSSL)"
    puts "Press (4) to select Trial mode (RPS)"
    puts "Press (5) to quit"
  end

  def core_menu
    system('clear') || system('cls')
    box_print("--- Rock, Paper, Scissors, Spock, Lizard ---")
    show_core_choices
    loop do
      @choice = gets.chomp.to_i
      break router if [1, 2, 3, 4, 5].include?(choice)
      puts "That's not a valid choice. Try again."
    end
  end

  def again?
    str = ""
    loop do
      puts "\nAgain? (y/n)"
      str = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(str)
      puts "That's not a valid choice. Try again."
    end
    @choice = 0 if ['n', 'no'].include?(str)
    router
  end

  def router
    case choice
    when 0 then core_menu
    when 1 then RpsslGame.new.play
    when 2 then RpsGame.new.play
    when 3 then RpsslTrials.new.play
    when 4 then RpsTrials.new.play
    when 5 then Engine.stop
    end
  end

  def user_quits
    choice == 5
  end
end

class RpsFormatter
  def initialize(history, p1, p2)
    @history = history
    @p1 = p1
    @p2 = p2
    @total_rounds = @history.size
    @draw_count = @total_rounds - @p1.score - @p2.score
    @p1_stats = @history.map(&:first).tally.to_a.sort
    @p2_stats = @history.map(&:last).tally.to_a.sort
  end

  def show_stats
    generate_perct
    show_w_l
    show_hand_frq
  end

  private

  attr_writer :p1_perct, :p2_perct, :draw_perct

  def generate_perct
    @p1_perct = (@p1.score / @total_rounds.to_f * 100).round(2)
    @p2_perct = (@p2.score / @total_rounds.to_f * 100).round(2)
    @draw_perct = (@draw_count / @total_rounds.to_f * 100).round(2)
  end

  def show_w_l
    puts "\nMatch Stats"
    puts "---------------"
    puts "Out of #{@total_rounds} rounds..."
    puts "\t- #{@p1.name} won #{@p1.score} / #{@total_rounds} rounds " \
         "( #{@p1_perct} % )"
    puts "\t- #{@p2.name} won #{@p2.score} / #{@total_rounds} rounds " \
         "( #{@p2_perct} % )"
    puts "\t- No one won #{@draw_count} / #{@total_rounds} rounds (Tie!) " \
         "( #{@draw_perct} % )"
  end

  def show_hand_frq
    [[@p1.name, @p1_stats], [@p2.name, @p2_stats]].each do |arr|
      puts "#{arr[0]} chose..."
      arr[1].each do |hand, frq|
        puts "\t- #{hand} #{frq} time(s)" \
             " ( #{(frq / @total_rounds.to_f * 100).round(2)} % )"
      end
    end
    puts "---------------"
  end
end

class RpsBones
  def initialize
    @p1 = Comp.new("Comp")
    @history = []
  end

  private

  WHO_WINS = { "rock" => %w(lizard scissors),
               "paper" => %w(rock spock),
               "scissors" => %w(paper lizard),
               "spock" => %w(rock scissors),
               "lizard" => %w(spock paper) }

  attr_accessor :p1, :p2, :history, :game_name

  def players_go(game_name)
    p1.throw(game_name)
    p2.throw(game_name)
  end

  def round_winner
    if WHO_WINS[p1.hand].include?(p2.hand)
      p1.name
    elsif WHO_WINS[p2.hand].include?(p1.hand)
      p2.name
    else
      "No one"
    end
  end

  def update_score(who_won)
    p1.score += 1 if who_won == p1.name
    p2.score += 1 if who_won == p2.name
  end

  def update_history
    history << [p1.hand, p2.hand]
  end

  def show_stats
    RpsFormatter.new(history, p1, p2).show_stats
  end
end

class RpsTrials < RpsBones
  def initialize
    super
    @p2 = Comp.new("Comp2")
    @game_name = "Rock, Paper, Scissors"
  end

  def play
    trial_welcome
    how_many_rounds?
    run_trials until trial_over?
    show_stats
  end

  private

  attr_accessor :round_count

  def trial_welcome
    system('clear') || system('cls')
    puts "In Trial Mode, a large number of #{game_name} rounds " \
         "between 2 computers will be simulated."
  end

  def how_many_rounds?
    trial_count = nil
    loop do
      puts "Enter the number of rounds to be simulated: " \
           "(100 to 1_000_000 inclusive):"
      trial_count = gets.chomp.to_i
      break if (100..1_000_000).include?(trial_count)
      puts "That's not a valid input. Try again."
    end
    @round_count = trial_count
  end

  def trial_over?
    history.size == round_count
  end

  def run_trials
    players_go(game_name)
    update_score(round_winner)
    update_history
  end
end

class RpsslTrials < RpsTrials
  def initialize
    super
    @game_name = "Rock, Paper, Scissors, Spock, Lizard"
  end
end

class RpsGame < RpsBones
  include Displayable

  def initialize
    super
    @p2 = Human.new("Human")
    @game_name = "Rock, Paper, Scissors"
  end

  def play
    game_welcome
    how_many_wins?
    game_begin
    run_rounds until match_winner
    show_result
    show_stats
  end

  private

  attr_accessor :wins_needed

  def game_welcome
    system('clear') || system('cls')
    puts "Let's play #{game_name} against a computer opponent"
    box_print("#{game_name} rules: 'scissors cuts paper " \
              "covers rock crushes scissors'")
  end

  def how_many_wins?
    win_count = nil
    loop do
      puts "Enter the number of rounds needed to win (2 to 10 inclusive): "
      win_count = gets.chomp.to_i
      break if (2..10).include?(win_count)
      puts "That's not a valid input. Try again."
    end
    @wins_needed = win_count
  end

  def game_begin
    system('clear') || system('cls')
    puts "Let's play #{game_name}!"
    puts "First to #{wins_needed} wins"
    puts "Press any key to start!"
    STDIN.getch
  end

  def run_rounds
    system('clear') || system('cls')
    show_scores
    players_go(game_name)
    show_moves
    show_round_winner
    update_score(round_winner)
    update_history
  end

  def match_winner
    return p1.name if p1.score == wins_needed
    return p2.name if p2.score == wins_needed
  end

  def show_scores
    puts "Score:"
    puts "---------"
    puts "#{p2.name}: #{p2.score}     #{p1.name}: #{p1.score}"
    puts
  end

  def show_moves
    puts "#{p2.name} chose #{p2.hand}. #{p1.name} chose #{p1.hand}."
  end

  def show_round_winner
    puts "#{round_winner} won this round!"
    puts "\nPress any key to continue"
    STDIN.getch
  end

  def show_result
    system('clear') || system('cls')
    box_print("#{match_winner} was the first to #{wins_needed}, " \
    "and won the match!")
    print "Final "
    show_scores
  end
end

class RpsslGame < RpsGame
  def initialize
    super
    @game_name = "Rock, Paper, Scissors, Spock, Lizard"
  end

  private

  def game_welcome
    system('clear') || system('cls')
    puts "Let's play #{game_name} against a computer opponent"
    box_print("#{game_name} rules: 'It's very simple. Scissors cuts paper, " \
              "paper covers rock, rock crushes lizard, lizard poisons Spock, " \
              "Spock smashes scissors, scissors decapitates lizard, " \
              "lizard eats paper, paper disproves Spock, Spock vaporizes " \
              "rock, and, as it always has, rock crushes scissors.' " \
              "-- Sheldon of TBBT")
  end
end

class Player
  attr_reader :name
  attr_accessor :hand, :score

  def initialize(name)
    @name = name
    @score = 0
  end
end

class Human < Player
  def throw(game_name)
    rps_throw if game_name == "Rock, Paper, Scissors"
    rpssl_throw if game_name == "Rock, Paper, Scissors, Spock, Lizard"
  end

  private

  def rps_throw
    key_tr = { "r" => "rock", "p" => "paper", "s" => "scissors" }
    key = ""
    loop do
      puts "(r)ock, (p)aper, or (s)cissors?"
      key = gets.chomp
      break if key_tr.keys.include?(key)
      puts "That's not a valid input. Try again."
    end
    @hand = key_tr[key]
  end

  def rpssl_throw
    key_tr = { "r" => "rock", "p" => "paper", "s" => "scissors",
               "o" => "spock", "l" => "lizard" }
    key = ""
    loop do
      puts "(r)ock, (p)aper, (s)cissors, sp(o)ck, (l)izard?"
      key = gets.chomp
      break if key_tr.keys.include?(key)
      puts "That's not a valid input. Try again."
    end
    @hand = key_tr[key]
  end
end

class Comp < Player
  def throw(game_name)
    rps_throw if game_name == "Rock, Paper, Scissors"
    rpssl_throw if game_name == "Rock, Paper, Scissors, Spock, Lizard"
  end

  private

  def rps_throw
    @hand = ["rock", "paper", "scissors"].sample
  end

  def rpssl_throw
    @hand = ["rock", "paper", "scissors", "spock", "lizard"].sample
  end
end

Engine.new.start
