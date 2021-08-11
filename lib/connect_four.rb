# frozen_string_literal: true

class ConnectFour
  def initialize(board = Array.new(6) { Array.new(7) })
    @board = board
  end

  # the horizontal pattern is always start -> start + 4
  # instead of writing out that array combinations maybe determine if it fits the pattern?
  #
  HORIZONTAL_WINS = [
    [0, 1, 2, 3],
    [6, 7, 8, 9],
    [12, 13, 14, 15],
    [18, 19, 20, 21],
    [24, 25, 26, 27],
    [30, 31, 32, 33],
    [36, 37, 38, 39],
    [1, 2, 3, 4],
    [7, 8, 9, 10],
    [13, 14, 15, 16],
    [19, 20, 21, 22],
    [25, 26, 27, 28],
    [31, 32, 33, 34],
    [37, 38, 39, 40],
    [2, 3, 4, 5],
    [8, 9, 10, 11],
    [14, 15, 16, 17],
    [20, 21, 22, 23],
    [26, 27, 28, 29],
    [32, 33, 34, 35],
    [38, 39, 40, 41]
  ].freeze

  VERTICAL_WINS = [
    [0, 6, 12, 18, 24, 30, 36],
    [1, 7, 13, 19, 25, 31, 37],
    [2, 8, 14, 20, 26, 32, 38],
    [3, 9, 15, 21, 27, 33, 39],
    [4, 10, 16, 22, 28, 34, 40],
    [5, 11, 17, 23, 29, 35, 41]
  ].freeze

  def return_board
    p @board
    @board
  end

  def check_winner?
    # index?
    # @board.index(@player)
    @board.index('X')
    return true if HORIZONTAL_WINS.any? { |line| line.all? { |square| @board[square] == 'X' } }
    return true if VERTICAL_WINS.any? { |line| line.all? { |square| @board[square] == 'X' } }

    false
  end
end
