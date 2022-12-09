require 'io/console'

SUITS = ['♠', '♥', '♦', '♣']
POSSIBLE_CARDS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }
MAX_NO_BUST = 21
NUM_TO_WIN = 1

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  system('clear') || system('cls')
  prompt "Let's play 21!"
  prompt "First to #{NUM_TO_WIN} wins"
  prompt ""
  prompt "Press any key to start!"
  STDIN.getch
end

def new_deck
  (POSSIBLE_CARDS * 4).zip(SUITS * 13).map do |card|
    card_hash = {}
    card_hash[:rank] = card[0]
    card_hash[:suit] = card[1]
    card_hash[:value] = CARD_VALUES[card[0]]
    card_hash
  end
end

def deal_card!(player, deck)
  drawn_card = deck.shift
  player << drawn_card
end

def add_hidden_card!(dealer)
  dealer << { rank: "?", suit: "?", value: 0 }
end

def reveal_card!(dealer, gdeck)
  dealer.delete_at(1)
  deal_card!(dealer, gdeck)
  prompt "Dealer will reveal card"
  thinking
end

# rubocop: disable Metrics/AbcSize, Metrics/MethodLength
def display_hand(whos_hand)
  (whos_hand.size).times { print " ________   " }
  puts
  whos_hand.each do |card|
    print "|#{card[:rank]}#{card[:suit]}".ljust(9) + "|  "
  end
  3.times do
    puts
    (whos_hand.size).times { print "|        |" + "  " }
  end
  puts
  whos_hand.each do |card|
    print "|" + "#{card[:rank]}#{card[:suit]}|".rjust(9) + "  "
  end
  print "Total: #{find_total(whos_hand)}"
  puts
  (whos_hand.size).times { print " ‾‾‾‾‾‾‾‾   " }
  puts
end
# rubocop: enable Metrics/AbcSize, Metrics/MethodLength

def display_board(player, dealer, scoreboard)
  system('clear') || system('cls')
  puts "  Dealer: #{scoreboard[:Dealer]}\t  Player: #{scoreboard[:Player]}"
  puts " ___________________________ "
  puts "|          ROUND #{scoreboard[:Round_num]}".ljust(28) + "|"
  puts "|___________________________|"
  puts "\nDealer"
  display_hand(dealer)
  3.times { puts "" }
  puts "Player"
  display_hand(player)
  puts
end

def thinking
  print "=> "
  3.times do
    print "."
    sleep(1)
  end
  puts ""
end

def new_round!(player, dealer, deck)
  2.times { deal_card!(player, deck) }
  deal_card!(dealer, deck)
  add_hidden_card!(dealer)
end

def find_total(whos_hand)
  total = 0
  ace_count = whos_hand.count { |card| card[:rank] == 'A' }
  whos_hand.reverse.each { |card| total += card[:value] }
  ace_count.times { total -= 10 if total > MAX_NO_BUST }
  total
end

def busted?(whos_hand)
  find_total(whos_hand) > MAX_NO_BUST
end

def hit_or_stay(player)
  choice = nil
  loop do
    prompt "1) Hit or 2) Stay"
    prompt "(Note..you currently have 21!)" if find_total(player) == 21
    choice = gets.chomp.to_i
    break if [1, 2].include?(choice)
    prompt "That's not a valid choice. Please enter 1 or 2."
  end
  choice
end

def player_goes!(player, dealer, gdeck, scoreboard)
  display_board(player, dealer, scoreboard)
  prompt "Player's turn"
  loop do
    display_board(player, dealer, scoreboard)
    player_action = hit_or_stay(player)
    if player_action == 1
      deal_card!(player, gdeck)
      break if busted?(player)
    else
      prompt "You chose to stay"
      break thinking
    end
  end
  display_board(player, dealer, scoreboard)
end

def dealer_goes!(dealer, player, gdeck, scoreboard)
  prompt "Dealer's turn"
  reveal_card!(dealer, gdeck)
  display_board(player, dealer, scoreboard)
  until find_total(dealer) > 16
    prompt "Dealer's turn"
    prompt "Dealer has 16 or less, and must hit"
    thinking
    deal_card!(dealer, gdeck)
    display_board(player, dealer, scoreboard)
  end
  return if busted?(dealer)
  prompt "Dealer has at least 17, and must stay"
  thinking
end

def run_round!(player, dealer, deck, hand_scores, scoreboard)
  player_goes!(player, dealer, deck, scoreboard)
  dealer_goes!(dealer, player, deck, scoreboard) unless busted?(player)
  hand_scores[:Player] = find_total(player)
  hand_scores[:Dealer] = find_total(dealer)
  display_board(player, dealer, scoreboard)
end

def detect_match_winner(scoreboard)
  return 'Player' if scoreboard[:Player] == NUM_TO_WIN
  return 'Dealer' if scoreboard[:Dealer] == NUM_TO_WIN
  nil
end

def match_won?(scoreboard)
  !!detect_match_winner(scoreboard)
end

def match_continues(scoreboard)
  prompt "Press any key to continue to round #{scoreboard[:Round_num]}"
  STDIN.getch
end

def match_ends
  prompt "Match is over! Press any key to continue."
  STDIN.getch
end

def show_result(hand_scores, scoreboard)
  if hand_scores[:Player] > MAX_NO_BUST
    puts "Player lost round #{scoreboard[:Round_num]}, " \
         "busted with: #{hand_scores[:Player]}"
  elsif hand_scores[:Dealer] > MAX_NO_BUST
    puts "Player won round #{scoreboard[:Round_num]}. " \
         "Dealer busted with: #{hand_scores[:Dealer]}"
  elsif hand_scores[:Dealer] > hand_scores[:Player]
    puts "Dealer won round #{scoreboard[:Round_num]}. " \
         "#{hand_scores[:Dealer]} vs #{hand_scores[:Player]}"
  elsif hand_scores[:Player] > hand_scores[:Dealer]
    puts "You won round #{scoreboard[:Round_num]}. " \
         "#{hand_scores[:Player]} vs #{hand_scores[:Dealer]}"
  else
    puts "Push for round #{scoreboard[:Round_num]}. " \
         "Both had #{hand_scores[:Dealer]}"
  end
end

def update_scores(hand_scores, scoreboard)
  if hand_scores[:Player] > MAX_NO_BUST
    scoreboard[:Dealer] += 1
  elsif hand_scores[:Dealer] > MAX_NO_BUST
    scoreboard[:Player] += 1
  elsif hand_scores[:Dealer] > hand_scores[:Player]
    scoreboard[:Dealer] += 1
  elsif hand_scores[:Player] > hand_scores[:Dealer]
    scoreboard[:Player] += 1
  else
    scoreboard[:Pushes] += 1
  end
end

def post_round(hand_scores, scoreboard)
  show_result(hand_scores, scoreboard)
  update_scores(hand_scores, scoreboard)
  scoreboard[:Round_num] += 1
  match_won?(scoreboard) ? match_ends : match_continues(scoreboard)
end

def display_final_score(final_score, winner)
  system('clear') || system('cls')
  puts "\n#{winner} won the 21 match!"
  puts " ___________________________ "
  puts "|        Final Score        |"
  puts "|___________________________|"
  puts "          Player: #{final_score[:Player]}"
  puts "          Dealer: #{final_score[:Dealer]}"
  puts "         (Pushes: #{final_score[:Pushes]})"
  puts
end

def play_again?
  again = nil
  loop do
    prompt "Play again? (y or n)"
    again = gets.chomp
    break if ['y', 'yes', 'n', 'no'].include?(again.downcase)
    prompt "That's not a valid choice. Please enter 'y' or 'n'."
  end
  unless ['y', 'yes'].include?(again.downcase)
    prompt "Thanks for playing 21! Goodbye!"
    exit
  end
end

loop do
  welcome
  deck = new_deck.shuffle + new_deck.shuffle
  scoreboard = { Round_num: 1, Player: 0, Dealer: 0, Pushes: 0 }
  loop do
    player = []
    dealer = []
    hand_scores = { Player: 0, Dealer: 0 }
    new_round!(player, dealer, deck)
    run_round!(player, dealer, deck, hand_scores, scoreboard)
    post_round(hand_scores, scoreboard)
    break if match_won?(scoreboard)
  end
  display_final_score(scoreboard, detect_match_winner(scoreboard))
  play_again?
end
