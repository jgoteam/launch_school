require 'io/console'
require 'timeout'
include Process

module Displayable
  WIDTH = 65

  def separator
    "-" * Displayable::WIDTH
  end

  def title_banner
    system('clear') || system('cls')
    header_box("0o0 -- Three Tater Tots -- o0o")
    puts
  end

  def header_box(text)
    box_top
    info_box(text)
  end

  def info_box(text)
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

  def joiner(options)
    rest, last = options.partition { |el| el != options[-1] }
    joined = "#{rest.join(', ')} or #{last.join} ?"
    puts options.size == 1 ? options[0] : joined
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
    (0..chars.size - 1).step(WIDTH - 9) do |limit| # -9 for padding
      limit.downto(0) do |idx|
        break chars.insert(idx, "\n") if chars[idx] == ' '
      end
    end
    chars.join.split("\n")
  end

  def grid_top(x) # (x - 1) is the display multipler
    print "#{(' ' * x * (x - 1) + '|') * (x - 1)}\n"
  end

  def grid_middle(x, row)
    row.size.times do |idx|
      line = "#{row[idx].center(x * (x - 1))}|"
      line = "#{line.chop}\n" if idx == (x - 1)
      print line
    end
  end

  def grid_bottom(x)
    puts "#{(' ' * x * (x - 1) + '|') * (x - 1)}\n"
  end

  def horizontal_line(x)
    puts ("#{'-' * x * (x - 1)}+" * x).chop
  end
end

module TttBannerable
  def high_scores_banner
    title_banner
    puts "Top 10 High Scores"
    puts "-" * 18 # str_size above
  end

  def turn_bonus_banner
    title_banner
    puts "Going first nets you +0 points."
    puts "\nGoing second nets you +1500 points."
    puts separator
  end

  def marker_choice_banner
    title_banner
    puts "Choose your Tater Tot:"
    puts "\n(The number 0 or the letter o)"
    puts separator
  end

  def turn_order_banner
    title_banner
    puts "#{players[0].name} (#{players[0].mark}) is going first."
    puts "#{players[1].name} (#{players[1].mark}) is going second."
    puts separator
  end

  def new_turn_banner(player)
    puts "\n#{player.name}'s turn ( #{player.mark} )"
    puts '-' * (player.name.size + 14) # 14 for other_chars_size
  end

  def human_turn_banner
    puts "You have #{(timer.time_left).round(2)} second(s) to move!"
    puts "\nSelect a square to place your marker:"
    joiner(board.empty_squares)
  end

  def game_over_banner(loss_method)
    system('clear') || system('cls')
    header_box("-----Game Over-----")
    info_box(loss_method)
  end

  def victory_banner
    system('clear') || system('cls')
    header_box("0oo0o WINNER WINNER NINE TATER TOT DINNER o00o")
    info_box("-----#{player_one.name.upcase}, YOU WON!-----")
  end
end

module ProceduralAlgo
  def algo_move(board, mark, other_mark)
    options =
      [close_line(board, mark), close_line(board, other_mark),
       try_middle(board), check_forks(board, mark, other_mark),
       try_opposite_corner(board, mark, other_mark), safe_move(board)]
    options.find { |choice| !choice.nil? }
  end

  private

  def close_line(board, marker)
    choices =
      board.winning_lines.each_with_object([]) do |line, arr|
        third = line.select { |sq| board.squares[sq] != marker }
        arr << third[0] if third.size == 1 && board.squares[third[0]] == ' '
      end
    choices.sample
  end

  def try_middle(board)
    '5' if board.squares['5'] == ' '
  end

  def check_forks(board, mark, other_mark)
    if board.squares['5'] == mark && board.empty_corners.size == 2
      side_fork(board, mark, other_mark)
    elsif board.empty_sides.size == 3 && board.empty_corners.size == 3
      corner_fork(board, mark, other_mark)
    end
  end

  def corner_fork(board, mark, other_mark)
    atk_corners =
      board.empty_corners.each_with_object([]) do |a_sq, choices|
        board.winning_lines.each do |line|
          marked, rest = line.partition { |sq| board.squares[sq] == mark }
          choices << a_sq if marked.size == 1 && rest.include?(a_sq)
        end
      end
    find_threat(board, atk_corners, other_mark)
  end

  def side_fork(board, mark, other_mark)
    atk_sides =
      board.empty_sides.each_with_object([]) do |a_sq, choices|
        board.winning_lines.each do |line|
          marked, rest = line.partition { |sq| board.squares[sq] == mark }
          choices << a_sq if marked.size == 1 && rest.include?(a_sq)
        end
      end
    find_threat(board, atk_sides, other_mark)
  end

  def find_threat(board, squares, other_mark)
    threats = []
    board.winning_lines.each do |line|
      squares.each do |sq|
        threats << sq if board.squares.values_at(*line).count(other_mark) == 1
      end
    end
    threats.max_by { |sq| threats.count(sq) }
  end

  def try_opposite_corner(board, mark, other_mark)
    corner_pairs = [['1', '9'], ['3', '7']]
    corner_pairs.each do |pair|
      line_markers = pair.map { |sq| board.squares[sq] }
      if line_markers.count(other_mark) == 1 &&
         line_markers.count(" ") == 1 && board.squares['5'] == mark
        return pair.find { |sq| board.squares[sq] == ' ' }
      end
    end
    nil
  end

  def safe_move(board)
    moves = [board.empty_corners.sample, board.empty_sides.sample]
    moves.find { |move| !move.nil? }
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
    title_banner
    core_choices
    loop do
      self.choice = gets.chomp.to_i
      break router if (1..4).include?(choice)
      puts "That's not a valid choice. Try again."
    end
  end

  def core_choices
    core_choices = <<-HEREDOC
    Press (1) to play Three Tater Tots
    Press (2) to view rules
    Press (3) to view high scores
    Press (4) to quit
    HEREDOC
    puts core_choices
  end

  def go_back
    puts "\nPress 'b' to go back to the main menu"
    loop do
      confirm = gets.chomp.downcase
      break core_menu if ['b', 'back'].include?(confirm)
      puts "Invalid input. Press 'b' to go back to main menu."
    end
  end

  def router
    case choice
    when 1 then TttGame.new.play
    when 2 then TttGame.rules
    when 3 then TttGame.high_scores
    when 4 then Engine.stop
    end
  end

  def user_quits
    choice == 4
  end
end

class Timer
  attr_reader :elapsed
  attr_writer :limit

  def initialize
    @start_time = Float::INFINITY
    @elapsed = -Float::INFINITY
    @limit = Float::INFINITY
  end

  def start
    self.start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def stop
    self.stop_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    self.elapsed = stop_time - start_time
  end

  def time_left
    limit - split
  end

  def time_up?
    split > limit
  end

  def time_was_up
    elapsed > limit
  end

  def time_remaining
    limit - elapsed
  end

  private

  attr_reader :limit
  attr_writer :elapsed, :hx
  attr_accessor :start_time, :stop_time

  def split
    Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
  end
end

class TttRoundScore
  attr_reader :round, :time, :multiplier, :score

  def initialize(time, round)
    @round = round
    @time = time
    @multiplier = round * 100
    @score = (time * multiplier).round
  end

  def print_info
    puts "For Round #{round} with a #{multiplier}X multiplier..."
    puts "\tYou had #{time.round(2)} seconds left, " \
         "and earned #{(time * multiplier).round} points."
  end
end

class TttScore
  include Displayable

  attr_reader :total

  def initialize
    @total = 0
    @all_rounds = []
    @turn_bonus = false
  end

  def turn_bonus_active
    self.turn_bonus = true
    self.total += 1500
  end

  def add_round_score(round_score)
    all_rounds << round_score
    self.total += round_score.score
  end

  def print_detailed
    puts separator
    all_rounds.each(&:print_info)
    puts "\n+1500 point Second Turn Bonus" if turn_bonus
    puts separator
    puts "\nFinal Score: #{total}"
  end

  private

  attr_writer :total
  attr_accessor :all_rounds, :turn_bonus
end

class TttGrid
  include Displayable

  attr_accessor :squares

  BLANK_MARK = ' '
  MARKERS = ["0", "o"]

  def initialize(size, player_one, player_two)
    @size = size
    @player_one = player_one
    @player_two = player_two
    reset
  end

  def draw
    draw_grid(size, squares.values)
  end

  def reset
    self.squares =
      (1..size**2).each_with_object({}) do |sq, squares|
        squares[sq.to_s] = BLANK_MARK
      end
  end

  def empty_squares
    squares.select { |_, mark| mark == BLANK_MARK }.keys
  end

  def empty_corners
    empty_squares.intersection(['1', '3', '7', '9'])
  end

  def empty_sides
    empty_squares.intersection(['2', '4', '6', '8'])
  end

  def full?
    squares.values.all? { |mark| mark != BLANK_MARK }
  end

  def winning_lines
    rows_and_columns + diagonal_one + diagonal_two
  end

  def winner
    winning_lines.each do |line|
      return player_one.name if line_complete?(*line, player_one.mark)
      return player_two.name if line_complete?(*line, player_two.mark)
    end
    full? ? "No one" : nil
  end

  private

  def line_complete?(*line, marker)
    squares.values_at(*line).count(marker) == size
  end

  def rows_and_columns
    marks = squares.keys
    rows = marks.each_slice(size).to_a
    columns = rows[0].zip(*rows[1..-1])
    rows + columns
  end

  def diagonal_one
    marks = squares.keys
    [(0...size**2).step(size + 1).map { |idx| marks[idx] }]
  end

  def diagonal_two
    marks = squares.keys
    [(size - 1...size**2 - 1).step(size - 1).map { |idx| marks[idx] }]
  end

  attr_reader :size
  attr_accessor :player_one, :player_two
end

class TttGame
  extend Displayable
  include Displayable
  extend TttBannerable
  include TttBannerable

  attr_accessor :board, :player_one, :player_two, :timer

  TIME_LIMITS = { 1 => 25, 2 => 20, 3 => 15, 4 => 11, 5 => 8 }

  RULES =
    "The objective of Three Tater Tots is to get through #{TIME_LIMITS.size} " \
    "rounds of Tic-Tac-Toe against a computer in the least amount of time. " \
    "Each subsequent round will have a shorter time limit than the previous " \
    "round. Time runs down regardless of whose turn it is, and also during " \
    "animation times. You lose the game by either losing against the " \
    "computer for the round, or by running out of time. "

  POINTS_INFO = <<-HEREDOC

Points are calculated as follows: (Note: 0 points to start )
#{separator}
Per round(5):
  + (round # * 100) * (seconds left) points

At the end of the game (if you win):
  + 2500 points if you elected to go second
#{separator}

HEREDOC

  private_constant :TIME_LIMITS, :RULES, :POINTS_INFO

  def initialize
    @player_one = Human.new
    @player_two = Comp.new
    @players = [@player_one, @player_two]
    @round = 1
    @timer = Timer.new
  end

  def play
    enter_name
    choose_turn
    choose_mark
    game_begin
    run_rounds until loser? || rounds_complete?
    loser? ? game_over : victory
  end

  def self.rules
    title_banner
    header_box("Rules")
    info_box(RULES)
    puts POINTS_INFO
  end

  def self.high_scores
    high_scores_banner
    raw = File.readlines('high_scores.txt')
    top_ten = raw.max_by(10) { |pair| pair.split(' ')[1].to_i }
    top_ten.each_with_index do |pair, idx|
      pair.split(' ').each_slice(2).each do |data|
        name = data[0]
        score = data[1]
        puts "#{idx + 1}. #{name} \t #{score}"
      end
    end
  end

  private

  attr_accessor :players, :round

  def enter_name
    title_banner
    name = ""
    loop do
      puts "Enter your name: "
      name = gets.chomp.strip
      break if name_valid?(name)
    end
    player_one.name = name
  end

  def name_valid?(name)
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
    turn_bonus_banner
    ans = ""
    loop do
      puts "Do you want to go first? (y/n)"
      ans = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(ans)
      puts "That's not a valid choice. Try again."
    end
    players.rotate! if ['n', 'no'].include?(ans)
    player_one.score.turn_bonus_active if ['n', 'no'].include?(ans)
  end

  def choose_mark
    marker_choice_banner
    choice = " "
    loop do
      joiner(TttGrid::MARKERS)
      choice = gets.chomp.strip.downcase
      break if TttGrid::MARKERS.include?(choice)
      puts "Invalid input. Try again"
    end
    player_one.mark, player_two.mark =
      TttGrid::MARKERS.partition { |el| el == choice }.map(&:first)
  end

  def game_begin
    turn_order_banner
    self.board = TttGrid.new(3, player_one, player_two)
    puts "Press any key to begin"
    STDIN.getch
  end

  def rounds_complete?
    round > TIME_LIMITS.size
  end

  def won?
    board.winner == player_one.name || board.full?
  end

  def lost?
    board.winner == player_two.name || timer.time_up?
  end

  def loser?
    board.winner == player_two.name || timer.time_was_up
  end

  def run_rounds
    pre_round
    timer.start
    players_go unless lost?
    timer.stop
    post_round unless loser?
  end

  def pre_round
    timer.limit = TIME_LIMITS[round]
    title_banner
    header_box("Round #{round}")
    info_box("\nYou have #{TIME_LIMITS[round]} seconds to finish " \
    "the game without losing! Press any key to start round")
    STDIN.getch
  end

  def players_go
    loop do
      title_banner
      board.draw
      player_goes(players[0])
      break players.rotate! if lost?
      break if won?
      players.rotate!
    end
  end

  def round_win
    title_banner
    board.draw
    phrase =
      board.winner == player_one.name ? "beating" : "drawing with"
    puts "You won round #{round} by #{phrase} #{player_two.name}."
    puts "And you did it in #{timer.elapsed.round(2)} seconds!"
  end

  def user_ready?
    puts "Press any key to continue "
    print "to round #{round + 1}" unless won?
    STDIN.getch
  end

  def post_round
    round_win
    user_ready?
    save_round_score(timer.time_remaining, round)
    return if rounds_complete?
    board.reset
    self.round += 1
  end

  def save_round_score(time_remaining, round)
    score = TttRoundScore.new(time_remaining, round)
    player_one.score.add_round_score(score)
  end

  def loss_method
    lost_by_time = "You ran out of time. "
    time_addendum =
      "You were unable to complete round #{round} in #{TIME_LIMITS[round]} " \
      "seconds. Time elapsed: #{timer.elapsed.round(2)} seconds"
    lost_by_game =
      "#{player_two.name} (#{player_two.mark}) got Three Tater Tots"
    timer.time_up? ? lost_by_time + time_addendum : lost_by_game
  end

  def game_over
    game_over_banner(loss_method)
    puts
    board.draw
    puts
    return if round == 1
    record_score
    print_score
  end

  def victory
    victory_banner
    record_score
    print_score
  end

  def record_score
    scores = File.open('high_scores.txt', 'a')
    scores.write("#{player_one.name} ", "#{player_one.score.total} \n")
    scores.close
  end

  def print_score
    puts "\n#{player_one.name}'s score breakdown..."
    player_one.score.print_detailed
    puts
  end

  def player_goes(player)
    new_turn_banner(player)
    if player.is_a?(Human)
      begin
        Timeout.timeout(timer.time_left) { human_goes }
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
      human_turn_banner
      choice = gets.chomp.strip
      break if board.empty_squares.include?(choice)
      puts "That's not a valid choice. Try again."
    end
    board.squares[choice] = players[0].mark
  end

  def comp_goes
    sleep(0.5)
    comp_choice = player_two.move(board)
    board.squares[comp_choice] = players[0].mark
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
  include ProceduralAlgo
  attr_accessor :name, :mark, :other_mark

  def initialize
    @name = ["Hash Brown", "Waffle Fry", "French Fry", "Steak Fry"].sample
  end

  def move(board)
    other_mark =
      TttGrid::MARKERS.reject { |el| el == mark }[0]
    algo_move(board, mark, other_mark)
  end
end

Engine.new.start
