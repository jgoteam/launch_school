require 'io/console'

module Displayable
  def prompt(msg = "")
    puts "=> #{msg}"
  end

  def thinking
    print "=> "
    3.times do
      print "."
      sleep(1)
    end
    puts
  end

  def display_hand(hand)
    hand_top(hand)
    hand_middle(hand)
    hand_bottom(hand)
  end

  def display_round_info(player, dealer, scorer, round)
    puts "  #{dealer.name}: #{scorer.total[dealer.name.to_sym]}\t  " \
         "#{player.name}: #{scorer.total[player.name.to_sym]}"
    puts header_box("ROUND #{round}")
  end

  def display_all_hands(player, dealer)
    puts "\n#{dealer.name}"
    display_hand(dealer.hand)
    3.times { puts "" }
    puts player.name
    display_hand(player.hand)
    puts
  end

  def display_final_score(scorer)
    system('clear') || system('cls')
    puts "\n#{scorer.winner} won the 21 match!"
    puts header_box("Final Score")
    scorer.total.each do |name, score|
      entry = "#{name}: #{score}"
      entry = name == :Pushes ? "(#{entry})" : entry
      puts entry.center(29)
    end
    puts
  end

  def header_box(msg)
    puts " ___________________________ "
    puts "|#{msg.center(27)}|"
    puts "|___________________________|"
  end

  private

  def hand_top(hand)
    (hand.size).times { print " ________   " }
    puts
    hand.each do |card|
      print "|#{card.rank}#{card.suit}".ljust(9) + "|  "
    end
  end

  def hand_middle(hand)
    3.times do
      puts
      (hand.size).times { print "|        |" + "  " }
    end
    puts
  end

  def hand_bottom(hand)
    hand.each do |card|
      print "|" + "#{card.rank}#{card.suit}|".rjust(9) + "  "
    end
    puts
    (hand.size).times { print " ‾‾‾‾‾‾‾‾   " }
    puts
  end
end

module Pauseable
  def welcome(num_to_win)
    system('clear') || system('cls')
    prompt "Let's play 21!"
    prompt "First to #{num_to_win} win(s)"
    prompt ""
    prompt "Press any key to start!"
    STDIN.getch
  end

  def match_continues(round_num)
    prompt "Press any key to continue to Round #{round_num}"
    STDIN.getch
  end

  def match_ends
    prompt "Match is over! Press any key to continue."
    STDIN.getch
  end

  def farewell
    prompt "Thanks for playing 21! Goodbye!"
    exit
  end
end

class Deck
  RANKS = (2..10).to_a + %i(J Q K A)
  SUITS = ['♠', '♥', '♦', '♣']
  private_constant :RANKS, :SUITS

  def initialize
    @deck = new_deck
  end

  def draw
    new_deck if deck.empty?
    deck.shift
  end

  private

  attr_accessor :deck

  def new_deck
    self.deck =
      (RANKS * 4).zip(SUITS * 13).each_with_object([]) do |card, deck|
        deck << Card.new(card[0], card[1])
      end.shuffle
  end
end

class Card
  attr_reader :rank, :suit

  VALUES = { J: 10, Q: 10, K: 10, A: 11 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.key?(rank) ? VALUES[rank] : rank
  end
end

class RoundScorer
  def initialize(player, dealer, round)
    @player = player
    @dealer = dealer
    @round = round
    @bust_limit = TwentyOneGame::MAX_NO_BUST
    @winner = nil
    @loser = nil
  end

  def print_result
    determine_result
    print_message
    puts
  end

  def who_won
    winner
  end

  private

  attr_reader :player, :dealer, :bust_limit, :round
  attr_accessor :winner, :loser, :messages

  def busted?
    !!who_busted
  end

  def who_busted
    return player if player.hand_total > bust_limit
    return dealer if dealer.hand_total > bust_limit
  end

  def whose_lower
    return player if player.hand_total < dealer.hand_total
    return dealer if dealer.hand_total < player.hand_total
  end

  def determine_result
    return if !busted? && !whose_lower
    self.loser = busted? ? who_busted : whose_lower
    self.winner = loser == player ? dealer : player
  end

  def print_message
    winner && loser ? non_push_message : push_message
  end

  def non_push_message
    puts "#{winner.name} won and #{loser.name} lost Round #{round}."
    busted? ? bust_message : score_message
  end

  def score_message
    puts "#{winner.hand_total} vs #{loser.hand_total}"
  end

  def bust_message
    puts "#{loser.name} busted with: #{loser.hand_total}"
  end

  def push_message
    puts "Push for Round #{round}. \nBoth had #{player.hand_total}"
  end
end

class MatchScorer
  attr_accessor :total

  def initialize(player_one_name, player_two_name)
    @total = { player_one_name.to_sym => 0,
               player_two_name.to_sym => 0, :Pushes => 0 }
    @num_to_win = TwentyOneGame::NUM_TO_WIN
  end

  def winner
    total.key(num_to_win).to_s
  end

  def winner?
    !!total.key(num_to_win)
  end

  def update(round_winner)
    if round_winner.nil?
      total[:Pushes] += 1
    else
      total[round_winner.name.to_sym] += 1
    end
  end

  def reset
    total.transform_values! { 0 }
  end

  private

  attr_reader :num_to_win
end

class Participant
  attr_accessor :name, :hand

  def initialize(name)
    @name = name
    @hand = []
    @bust_limit = TwentyOneGame::MAX_NO_BUST
  end

  def reset_hand
    hand.clear
  end

  def busted?
    hand_total > bust_limit
  end

  def hand_total
    total = hand.map(&:value).sum
    ace_count = hand.count { |card| card.rank == :A }
    ace_count.times { total -= 10 if total > bust_limit }
    total
  end

  private

  attr_reader :bust_limit
end

class TwentyOneGame
  include Displayable
  include Pauseable

  NUM_TO_WIN = 5
  MAX_NO_BUST = 21

  def initialize
    @player = Participant.new('Player')
    @dealer = Participant.new('Dealer')
    @deck = Deck.new
    @scorer = MatchScorer.new(player.name, dealer.name)
    @round = 1
  end

  def play
    reset_game
    welcome(NUM_TO_WIN)
    run_rounds until scorer.winner?
    display_final_score(scorer)
    play_again?
  end

  def reset_game
    scorer.reset
    self.round = 1
    self.deck = Deck.new
  end

  def run_rounds
    initial_deal
    display_main_ui
    player_goes
    dealer_goes unless player.busted?
    display_main_ui
    post_round
  end

  def initial_deal
    2.times { player.hand << deck.draw }
    dealer.hand << deck.draw
    add_hidden_card(dealer.hand)
  end

  def deal_card(hand)
    hand << deck.draw
  end

  def add_hidden_card(hand)
    hand << Card.new('?', '?')
  end

  def player_goes
    prompt "#{player.name}'s turn"
    player_cycles
    display_main_ui
  end

  def player_cycles
    loop do
      display_main_ui
      if hit_or_stay == 1
        player.hand << deck.draw
        return if player.busted?
      else
        prompt "You chose to stay"
        return thinking
      end
    end
  end

  def hit_or_stay
    choice = nil
    loop do
      prompt "1) Hit or 2) Stay"
      note_of_best_hand
      choice = gets.chomp.to_i
      break if [1, 2].include?(choice)
      prompt "That's not a valid choice. Please enter 1 or 2."
    end
    choice
  end

  def note_of_best_hand
    return unless player.hand_total == MAX_NO_BUST
    prompt "(Note..you currently have #{MAX_NO_BUST}!)"
  end

  def dealer_goes
    display_main_ui
    prompt "Dealer's turn"
    reveal_hidden_card(dealer.hand)
    display_main_ui
    dealer_hits until dealer.hand_total > 16
    return if dealer.busted?
    prompt "Dealer has at least 17, and must stay"
    thinking
  end

  def reveal_hidden_card(hand)
    hand.pop
    deal_card(hand)
    prompt "Dealer will reveal card"
    thinking
  end

  def dealer_hits
    prompt "Dealer's turn"
    prompt "Dealer has 16 or less, and must hit"
    thinking
    dealer.hand << deck.draw
    display_main_ui
  end

  def post_round
    dealer.hand.delete_if { |card| card.rank == '?' }
    round_results
    next_round_prep
    scorer.winner? ? match_ends : match_continues(round)
  end

  def round_results
    this_round =
      RoundScorer.new(player, dealer, round)
    this_round.print_result
    scorer.update(this_round.who_won)
  end

  def next_round_prep
    self.round += 1
    [player, dealer].each(&:reset_hand)
  end

  def display_main_ui
    system('clear') || system('cls')
    display_round_info(player, dealer, scorer, round)
    display_all_hands(player, dealer)
  end

  def play_again?
    again = nil
    loop do
      prompt "Play again? (y or n)"
      again = gets.chomp
      break if ['y', 'yes', 'n', 'no'].include?(again.downcase)
      prompt "That's not a valid choice. Please enter 'y' or 'n'."
    end
    ['y', 'yes'].include?(again.downcase) ? play : farewell
  end

  private

  attr_accessor :player, :dealer, :deck, :scorer, :round
end

TwentyOneGame.new.play
