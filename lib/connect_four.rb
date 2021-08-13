# frozen_string_literal: true

require './winner'
require 'colorize'

# connect four game
class ConnectFour
  # include Winner

  # six rows by seven columns
  def initialize(board = Array.new(6) { Array.new(7, '.') })
    @board = board
    @player = 'O'.colorize(:red)
  end

  # put all of the display in the same module as well
  def show_board
    index = 0
    puts "\n"
    @board.map do |line|
      puts "| #{line[0]} | #{line[1]} | #{line[2]} | #{line[3]} | #{line[4]} | #{line[5]} | #{line[6]} |"
      index += 1
    end
    puts '  0   1   2   3   4   5   6  '.colorize(:yellow)
  end

  def end_game
    if check_winner?
      puts "Congratulations player #{@player}, you won!"
    else
      puts "tough game, it's a draw!"
    end
  end

  # could definitely make this better
  def play_game
    until check_winner?
      toggle_player
      show_board
      player_input
      # break if check_winner?
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

  DIAGONAL_PATTERNS = [[1, -1],
                       [1, 1]].freeze
  #    [-1, -1],
  #    [-1, 1]

  # count the number of 'X' in each row
  def horizontal_wins?
    win = false
    @board.map do |line|
      win = check_row?(line)
      next unless win

      return true
    end
    false
  end

  # checking one line of the grid, go square by square
  def check_row?(arr)
    counter = 0
    arr.map do |square|
      return true if counter == 4

      if square == @player
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
      return true if check_column?(i)

      i += 1
    end
    false
  end

  def check_column?(index)
    counter = 0
    @board.map do |line|
      return true if counter == 3

      if line[index] == @player
        counter += 1
      elsif line[index] != @player
        counter = 0
      end
    end
    false
  end

  # if the index matches the pattern *4 then we know it's a match
  def diagonal_wins?
    whole_grid = []
    one_line = []
    @board.map do |line|
      one_line = check_player_location(line) if line.include?(@player)
      whole_grid.push(one_line)
    end
    # remove nested array using flatten
    puts "position for #{@player}: #{whole_grid.flatten(1)}"

    if check_diagonal_pattern(whole_grid.flatten(1))
      p 'diagonal win'
      return true
    end

    false
  end

  # this thing is a beast.
  def check_diagonal_pattern(position)
    index = 0
    counter = 0

    # p "positions of #{@player}: #{position}"
    # position should never be nil
    # return false if position[index].nil?

    # i should see counter = 0 *2 if
    DIAGONAL_PATTERNS.map do |prediction|
      p "prediction #{prediction}"
      next_position = position[index] # <-- starting point
      while position.include?(next_position)
        next_position = []
        # alter the coordinates according to one of the DIAGONAL_PATTERNS
        # break if position[index].nil?

        # how i do conserve the negative? does it matter?
        p "prediction[1]: #{prediction[1]}"
        next_position.push(position[index][0] + (prediction[1]))
        next_position.push(position[index][1] + prediction[0])
        # if that coordinate is on the board, increment the counter
        p "prediction of the next point for #{@player}: #{next_position}"

        increment_counter?(position, next_position) ? counter += 1 : counter = 0

        puts "counter: #{counter}"
        return true if counter == 3
        break if counter == 0

        index += 1
      end
    end
    false
  end

  # counter isn't incrementing properly
  # arr represents the positions that that player currently has
  def increment_counter?(arr, curr_position)
    return true if arr.include?(curr_position)

    false

    # arr.map do |coord|
    #   # if the coordinate matches the next position according to the pattern, then you know it follows the diagonal pattern
    #   next unless coord == curr_position

    #   # specify the player
    #   puts "coordinate: #{coord}"
    #   return 1
    # end
    # 0
  end

  # find one line of indexes of a player's tic
  def check_player_location(line)
    arr = []
    index = 0
    line.map do |pos|
      if pos == @player
        temp = []
        temp.push(@board.index(line), index)
        arr.push(temp)
      end

      index += 1
    end
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
