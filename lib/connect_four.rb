# frozen_string_literal: true

# bugs: when a player enters a letter, it reads as 0
# when a player wins diaginally after entering invalid input, it takes 2 more moves for comp to read the win.
# ^ in this case there were 2 invalid inputs.
# entering invalid input seems to mess with the diagonal wins

require './winner'
require 'colorize'
require './display'

# connect four game
class ConnectFour
  include Winner
  include Display

  # six rows by seven columns
  def initialize(board = Array.new(6) { Array.new(7, '.') })
    @board = board
    @player = 'O'.colorize(:red)
  end

  def play_game
    until check_winner?
      toggle_player
      show_board
      player_input
      break if check_draw?

    end
    end_game
  end

  def check_draw?
    @board.map do |line|
      return false if line.include?('.')
    end
    true
  end

  def toggle_player
    case @player
    when 'X'.colorize(:light_blue)
      @player = 'O'.colorize(:red)
    when 'O'.colorize(:red)
      @player = 'X'.colorize(:light_blue)
    end
  end

  def player_input
    puts "player #{@player}, pick a column"
    column = gets.chomp.to_i

    valid_input?(column) ? update_board(column) : player_input
  end

  def update_board(column)
    index = 5
    while index > -1
      if @board[index][column].include?('.')
        @board[index][column] = @player
        return
      end
      index -= 1
    end
    puts 'that column is full'
    player_input
  end

  def valid_input?(column)
    return true if column.between?(0, 6)

    false
  end

  # def player_input
  #   puts "player #{@player}, pick a column"
  #   column_string = gets.chomp
  #   # use regex expressions to see if it matches '0-9'
  #   match = /\d/.match(column_string)
  #   # column = match[0].to_i
  #   valid_input?(match)
  # end

  # def update_board(column)
  #   index = 5
  #   while index > -1
  #     if @board[index][column].include?('.')
  #       @board[index][column] = @player
  #       return
  #     end
  #     index -= 1
  #   end
  #   puts 'that column is full'
  #   player_input
  # end

  # def valid_input?(match)
  #   player_input if match.nil?

  #   column = match[0].to_i
  #   update_board(column) if column.between?(0, 6)
  # end
end

# game = new.ConnectFour
# game.player_input
