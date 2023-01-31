require 'io/console'
require 'timeout'
include Process

module Displayable
  WIDTH = 65

  def separator
    "-" * Displayable::WIDTH
  end

  def banner_print
    system('clear') || system('cls')
    box_print("0o0 -- Three Tater Tots -- o0o")
    puts
  end

  def box_print(text)
    box_top
    box_cont(text)
  end

  def box_cont(text)
    box_middle(text)
    box_bottom
  end

  def draw_grid(x, squares)
    rows = squares.each_slice(x).to_a
    x.times do |idx|
      grid_top(x)
      grid_middle(x, rows[idx])
      grid_bottom(x)
      horizontal_line(x) unless idx == x - 1
    end
  end

  def joined_print(arr)
    rest, last = arr.partition { |el| el != arr[-1] }
    joined = "#{rest.join(', ')} or #{last.join} ?"
    puts arr.size == 1 ? arr[0] : joined
  end

  private

  def box_top
    puts ["+#{'-' * (WIDTH - 2)}+", "|#{' ' * (WIDTH - 2)}|"]
  end

  def box_bottom
    puts "+#{'-' * (WIDTH - 2)}+"
  end

  def box_middle(text)
    lines = (text.size / WIDTH).ceil + 2 # +2 to account for padding
    chopped = text_chopper(text)
    lines.times { |idx| puts "|#{chopped[idx].to_s.center(WIDTH - 2)}|" }
  end

  def text_chopper(text)
    chars = text.chars
    (0..chars.size - 1).step(WIDTH - 10) do |limit| # -10 for padding
      limit.downto(0) do |idx|
        break chars.insert(idx, "\n") if chars[idx] == ' '
      end
    end
    chars.join.split("\n")
  end

  def grid_top(x) # (x - 1) is the display multipler
    print "#{(" " * x * (x - 1) + "|")*(x - 1)}\n"
  end

  def grid_middle(x, row)
    row.size.times do |idx|
      line = "#{row[idx].center(x * (x - 1))}|"
      line = "#{line.chop}\n" if idx == (x - 1)
      print "#{line}"
    end
  end

  def grid_bottom(x)
    puts "#{(" " * x * (x - 1) + "|")*(x - 1)}\n"
  end

  def horizontal_line(x)
    puts ("#{"-" * x * (x - 1)}+" * x).chop
  end
end

class Timer
  attr_accessor :hx
  attr_writer :limit
  attr_reader :elapsed

  def initialize
    @hx = []
    @start = 0
    @limit = Float::INFINITY
  end

  def start
    @start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def stop
    @stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @elapsed = @stop - @start
  end

  def time_left
    @limit - split
  end

  def time_up?
    split > @limit
  end

  def save_times
    @hx << @limit - @elapsed
  end

  private

  def split
    Process.clock_gettime(Process::CLOCK_MONOTONIC) - @start
  end
end

class TttScore
  def initialize
    @total = 0
    @all_points = []
  end

  def turn_bonus
    @turn_bonus = true
  end

  def total
    @total
  end

  def detailed
    @all_points
  end

  def calculate(raw)
    raw.each_with_index do |time, idx|
      multiplier = 1 + (idx + 1) * 100
      @total += (time * multiplier).round
      @all_points << [time, multiplier, @total]
    end
    @total += 300 if @turn_bonus
  end
end

class Engine
  include Displayable

  def start
    core_menu
    go_back until user_quits
  end

  def self.stop
    puts "Thanks for playing Three Tater Tots. Goodbye!"
    exit
  end

  private

  attr_accessor :choice

  def core_menu
    banner_print
    show_core_choices
    loop do
      @choice = gets.chomp.to_i
      break router if (1..4).include?(choice)
      puts "That's not a valid choice. Try again."
    end
  end

  def show_core_choices
    puts "Press (1) to play Three Tater Tots"
    puts "Press (2) to view rules"
    puts "Press (3) to view high scores"
    puts "Press (4) to quit"
  end

  def go_back
    puts "Press any key to go back to the main menu"
    STDIN.getch
    core_menu
  end

  def router
    case choice
    when 1 then Ttt3x3.new.play
    when 2 then Ttt3x3.rules
    when 3 then TttScore.view_high_scores
    when 4 then Engine.stop
    end
  end

  def user_quits
    @choice == 4
  end
end

class TttGrid
  include Displayable

  attr_accessor :squares, :size

  BLANK_MARK = ' '
  MARKERS = ["0", "o"]

  def initialize(size, p1, p2)
    @size = size
    @p1 = p1
    @p2 = p2
    reset
  end

  def draw
    draw_grid(@size, @squares.values)
  end

  def reset
    @squares = (1..@size**2).each_with_object({}) { |num, hash| hash[num.to_s] = BLANK_MARK }
  end

  def empty_squares
    @squares.select { |_, mark| mark == BLANK_MARK }.keys
  end

  def full?
    @squares.values.all? { |mark| mark != BLANK_MARK }
  end

  def winning_lines
    marks = squares.keys
    rows = marks.each_slice(@size).to_a
    columns = rows[0].zip(*rows[1..-1])
    diagonal_1 = [(0...@size**2).step(@size + 1).map { |idx| marks[idx]}]
    diagonal_2 = [(@size - 1...@size**2 - 1).step(@size - 1).map { |idx| marks[idx]}]
    rows + columns + diagonal_1 + diagonal_2
  end

  def winner
    winning_lines.each do |line|
      return @p1.name if @squares.values_at(*line).count(@p1.mark) == @size
      return @p2.name if @squares.values_at(*line).count(@p2.mark) == @size
    end
    full? ? "No one" : nil
  end
end

class Ttt3x3
  extend Displayable
  include Displayable

  attr_accessor :brd, :players, :p1, :p2

  TIME_LIMITS = { 1 => 20, 2 => 15, 3 => 12, 4 => 10, 5 => 8 }

  RULES =
  "The objective of Three Tater Tots is to get through " \
  "#{TIME_LIMITS.size} rounds of Tic-Tac-Toe against an (unbeatable) AI, " \
  "in the least amount of time. Each subsequent round will have a shorter " \
  "time limit than the previous round. Time runs down regardless of whose " \
  "turn it is, and also during animation times. You lose the game by " \
  "either losing against the AI for the round, or by running out of time. "

  POINTS_INFO = <<-HEREDOC


Points are calculated as follows:
#{separator}
Per round(5): (1 + round # * 100) * (time left for round)

At the end of the game (if you win): +300 points for going second
#{separator}

HEREDOC

  def initialize
    @p1 = Human.new
    @p2 = Comp.new
    @players = [@p1, @p2]
    @round = 1
    @timer = Timer.new
  end

  def self.rules
    banner_print
    box_print("Rules")
    box_cont(RULES)
    puts POINTS_INFO
  end

  def play
    enter_name
    choose_turn
    choose_mark
    game_begin
    run_rounds until rounds_complete? || lost?
    lost? ? game_over : victory
  end

  def enter_name
    banner_print
    name = ""
    loop do
      puts "Enter your name: "
      name = gets.chomp.strip
      break if name_validator(name)
    end
    @p1.name = name
  end

  def name_validator(name)
    if name.size > 15
      puts "Invalid. Name must be less than 15 characters long."
    elsif name.match?(/[^A-Za-z0-9 _.\-]/)
      puts "Invalid. Only alphanumeric characters, along with " \
           "underscore, dash, and period characters are allowed."
    else
      true
    end
  end

  def choose_turn
    banner_print
    ans = ""
    puts "Going first nets you +0 points."
    puts "\nGoing second nets you +300 points, " \
         "but only if you win."
    puts separator
    loop do
      puts "Do you want to go first? (y/n)"
      ans = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(ans)
      puts "That's not a valid choice. Try again."
    end
    if ['n', 'no'].include?(ans)
      @players.rotate!
      @p1.score.turn_bonus
    end
  end

  def choose_mark
    banner_print
    choice = " "
    puts "Choose your Tater Tot:"
    puts "\n(The number 0 or the letter o)"
    puts separator
    loop do
      joined_print(TttGrid::MARKERS)
      choice = gets.chomp.strip.downcase
      break if TttGrid::MARKERS.include?(choice)
      puts "Invalid input. Try again"
    end
    @p1.mark, @p2.mark =
      TttGrid::MARKERS.partition { |el| el == choice }.map(&:first)
  end

  def game_begin
    banner_print
    puts "#{@players[0].name} (#{@players[0].mark}) is going first."
    puts "#{@players[1].name} (#{@players[1].mark}) is going second."
    puts separator
    @brd = TttGrid.new(3, @p1, @p2)
    puts "Press any key to begin"
    STDIN.getch
  end

  def rounds_complete?
    @round > TIME_LIMITS.size
  end

  def won?
    @brd.winner
  end

  def lost?
    @brd.winner == @p2.name || @timer.time_up?
  end

  def run_rounds
    pre_round
    players_go
    post_round unless lost?
  end

  def pre_round
    @timer.limit = TIME_LIMITS[@round]
    banner_print
    box_print("Round #{@round}")
    box_cont("\nYou have #{TIME_LIMITS[@round]} seconds to finish the game without losing! " \
              "Press any key to start round")
    STDIN.getch
  end

  def players_go
    @timer.start
    loop do
      banner_print
      @brd.draw
      player_goes(@players[0])
      break if won? || lost?
      @players.rotate!
    end
    @timer.stop
  end

  def round_win
    banner_print
    @brd.draw
    phrase = @brd.full? ? "drawing with" : "beating"
    puts "You won round #{@round} by #{phrase} #{@p2.name}."
    puts "And you did it in #{@timer.elapsed.round(2)} seconds!"
    puts "Press any key to continue "
    print "to round #{@round + 1}" unless won?
    STDIN.getch
  end

  def post_round
    round_win
    @timer.save_times
    @brd.reset
    @round += 1
  end

  def loser_message
    lost_by_time = "you ran out of time"
    time_addendum = "You were unable to complete round #{@round} in #{TIME_LIMITS[@round]} seconds. Time elapsed: #{@timer.elapsed.round(2)} seconds"
    lost_by_game = "AI got Three Tater Tots"
    @timer.time_up? ? lost_by_time + time_addendum : lost_by_game
  end

  def game_over
    system('clear') || system('cls')
    box_print("-----Game Over-----")
    box_cont("#{loser_message}")
    puts
    @brd.draw
    puts
  end

  def victory
    system('clear') || system('cls')
    box_print("0oo0o WINNER WINNER NINE TATER TOT DINNER o00o")
    box_cont("-----#{p1.name.upcase}, YOU WON!-----")
    @p1.score.calculate(@timer.hx)
    puts "#{@p1.name}'s score: #{@p1.score.total}"
  end

  def player_goes(player)
    puts "\n#{player.name}'s turn ( #{player.mark} )"
    puts "#{"-"*(player.name.size + 12)}" #12 for other_chars_size
    if player.is_a?(Human)
      begin
        Timeout.timeout(@timer.time_left) { human_goes }
      rescue Timeout::Error
        game_over
      end
    else
      comp_goes
    end
  end

  def human_goes
    choice = ""
    loop do
      puts "You have #{(@timer.time_left).round(2)} second(s) to move!"
      puts "\nSelect a square to place your marker:"
      joined_print(@brd.empty_squares)
      choice = gets.chomp.strip
      break if @brd.empty_squares.include?(choice)
      puts "That's not a valid choice. Try again."
    end
    @brd.squares[choice] = @players[0].mark
  end

  def comp_goes
    sleep(0.5)
    comp_choice = @brd.empty_squares.sample
    @brd.squares[comp_choice] = @players[0].mark
    puts "Computer chose slot #{comp_choice}"
    sleep(0.5)
  end
end

class Human
  attr_accessor :name, :mark, :score

  def initialize
    @score = TttScore.new
  end
end

class Comp
  attr_accessor :name, :mark, :other_mark

  def initialize
    @name = ["Maxaminiian", "Waffle Fry", "French Fry"].sample
  end
end

Engine.new.start
