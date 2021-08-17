# frozen_string_literal: true

DIAGONAL_PATTERNS = [[1, -1],
                     [1, 1],
                     [-1, -1],
                     [-1, 1]].freeze

# determines if there is a winner
module Winner
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

    return true if check_diagonal_pattern(whole_grid.flatten(1))

    false
  end

  # this thing is a beast.
  def check_diagonal_pattern(position)
    index = 0
    counter = 0
    DIAGONAL_PATTERNS.map do |prediction|
      next_position = position[index] # <-- starting point
      while position.include?(next_position)

        next_position = new_coordinates(prediction, next_position)
        position.include?(next_position) ? counter += 1 : counter = 0
        return true if counter == 3
        break if counter.zero?

        index += 1
      end
    end
    false
  end

  def new_coordinates(prediction, position)
    arr = []
    first_num = -1
    index = 0
    prediction.map do |pattern|
      first_num = if pattern.negative?
                    negative_position(position[index])
                  else
                    positive_position(position[index])
                  end
      arr.push(first_num)
      index += 1
    end
    arr
  end

  def negative_position(coord)
    num = coord
    num -= 1
    num
  end

  def positive_position(coord)
    num = coord
    num += 1
    num
  end

  def increment_counter?(arr, curr_position)
    p "increment counter arr #{arr}"
    return true if arr.include?(curr_position)

    false
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
