# frozen_string_literal: true

require 'matrix'

class ConnectFour
  # six rows by seven columns
  def initialize(board = Array.new(6) { Array.new(7) })
    @board = board
  end

  DIAGONAL_PATTERNS = [[1, -1],
                       [1, 1],
                       [-1, -1],
                       [-1, 1]].freeze

  # [[nil, nil, nil, nil, nil, 'X', nil],
  #             [nil, nil, nil, nil, nil, 'X', nil],
  #             [nil, nil, nil, nil, nil, 'X', nil],
  #             [nil, nil, nil, nil, nil, 'X', nil],
  #             [nil, nil, nil, nil, nil, nil, nil],
  #             [nil, nil, nil, nil, nil, nil, nil]]

  # [[nil, nil, nil, nil, nil, nil, nil],
  #            [nil, nil, nil, nil, nil, nil, nil],
  #            [nil, nil, nil, nil, nil, nil, nil],
  #            [nil, nil, nil, nil, nil, nil, nil],
  #            [nil, nil, nil, nil, nil, nil, nil],
  #            ['X', 'X', 'X', 'X', nil, nil, nil]]

  # [[nil, nil, nil, nil, nil, nil, nil],
  #             [nil, 'X', nil, nil, nil, nil, nil],
  #             [nil, nil, 'X', nil, nil, nil, nil],
  #             [nil, nil, nil, 'X', nil, nil, nil],
  #             [nil, nil, nil, nil, 'X', nil, nil],
  #             [nil, nil, nil, nil, nil, nil, nil]]

  def return_board
    # p @board
    @board.map do |line|
      p line
    end
    @board
  end

  # count the number of 'X' in each row
  def horizontal_wins?
    win = false
    @board.map do |line|
      win = check_row(line)
      return true if win
    end

    false
  end

  # checking one line of the grid, go square by square
  def check_row(line)
    counter = 0
    line.map do |square|
      return true if counter == 3

      if square == 'X' # @player
        counter += 1

      elsif square != 'X'
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

      if line[index] == 'X' # or @player
        counter += 1
      elsif line[index] != 'X'
        counter = 0
      end
    end
    false
  end

  # if the index matches the pattern *4 then we know it's a match
  def diagonal_wins?
    positions = []
    @board.map do |line|
      positions.push(check_player_location(line)) if line.include?('X') # or @player
    end

    return true if check_diagonal_pattern(positions)

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
    arr.push(line.index('X'))
    arr
  end

  def check_winner?
    return true if horizontal_wins?
    return true if vertical_wins?
    return true if diagonal_wins?

    false
  end
end

# game = ConnectFour.new
# game.return_board
# p game.diagonal_wins?
# game.horizontal_wins?
# game.vertical_wins?
