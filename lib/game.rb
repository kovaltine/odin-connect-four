# frozen_string_literal: true

require './connect_four'

# functions for the game loop

def connect_four_game
  while play_again?
    game = ConnectFour.new
    game.play_game
  end
  puts 'Thanks for playing!'
end

def play_again?
  puts "Would you like to play a game? 'y' for yes"
  input = gets.chomp.downcase
  return true if input == 'y'

  false
end

connect_four_game
