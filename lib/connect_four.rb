# frozen_string_literal: true

require_relative './winner'
require 'colorize'
require_relative './display'

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
end
