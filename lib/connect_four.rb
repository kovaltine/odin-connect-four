# frozen_string_literal: true

require 'matrix'

class ConnectFour
  # six rows by seven columns
  def initialize(board = Array.new(6) { Array.new(7, '.') })
    @board = board
    @player = 'X'
  end

  DIAGONAL_PATTERNS = [[1, -1],
                       [1, 1],
                       [-1, -1],
                       [-1, 1]].freeze

  # winner can be its own module? there's a lot of functions for that
  #

  def show_board
    index = 0
    puts "\n"
    @board.map do |line|
      puts "| #{line[0]} | #{line[1]} | #{line[2]} | #{line[3]} | #{line[4]} | #{line[5]} | #{line[6]} |"
      index += 1
    end
  end

  def play_game
    until check_winner?
      show_board
      player_input
      break if check_winner?

      toggle_player
    end

    #     toggle_player
    # @board.map do |line|
    #   while line.include?('.')
    #     show_board
    #     player_input
    #     break if check_winner?

    #     toggle_player
    #   end
    # end
    puts "#{@player} won!"
  end

  def toggle_player
    case @player
    when 'X'
      @player = 'O'
    when 'O'
      @player = 'X'
    end
  end

  def player_input
    puts "player #{@player}, pick a column"
    column = gets.to_i
    player_input until valid_input?(column)
    update_board(column)
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

  # count the number of 'X' in each row
  def horizontal_wins?
    win = false
    @board.map do |line|
      win = check_row?(line)
      # return true if win
      if win
        p 'horizontal win'
        p @board
        return true
      end

      false
    end
  end

  # checking one line of the grid, go square by square
  def check_row?(arr)
    counter = 0
    arr.map do |square|
      return true if counter == 4

      if square == @player # @player
        counter += 1

      elsif square != @player
        counter = 0
      end
    end

    false
  end

  # ex: first item in the line is 'X', continues for four lines
  def vertical_wins?
    i = 0
    until i > 6
      if check_column?(i)
        p 'vertical win'
        @board.map do |line|
          p line
        end
        return true
      end

      # return true if check_column?(i)

      i += 1
    end
    false
  end

  def check_column?(index)
    counter = 0
    @board.map do |line|
      return true if counter == 3

      if line[index] == @player # or @player
        counter += 1
      elsif line[index] != @player
        counter = 0
      end
    end
    false
  end

  # if the index matches the pattern *4 then we know it's a match
  def diagonal_wins?
    positions = []
    @board.map do |line|
      positions.push(check_player_location(line)) if line.include?(@player) # or @player
    end

    if check_diagonal_pattern(positions)
      p 'diagonal win'
      @board.map do |line|
        p line
      end
      true

    end

    # return true if check_diagonal_pattern(positions)

    false
  end

  def check_diagonal_pattern(position)
    index = 0
    counter = 0
    DIAGONAL_PATTERNS.map do |prediction|
      next_position = position[index] # <-- starting point
      while position.include?(next_position)
        next_position = []
        next_position.push(position[index][0] + prediction[0]) # <--the first number at pos[0]
        next_position.push(position[index][1] + prediction[1]) # <-- the second number at pos[0]
        counter += increment_counter(position, next_position)

        return true if counter == 3
      end
      index += 1
    end
    false
  end

  def increment_counter(arr, curr_position)
    if !arr.include?(curr_position)
      0
    else
      1
    end
  end

  # find all of the indexes of a player's tic
  def check_player_location(line)
    arr = []
    arr.push(@board.index(line))
    arr.push(line.index(@player))
    arr
  end

  def check_winner?
    return true if horizontal_wins?
    return true if vertical_wins?
    return true if diagonal_wins?

    false
  end
end

game = ConnectFour.new
game.play_game
# p game.diagonal_wins?
# game.horizontal_wins?
# game.vertical_wins?
