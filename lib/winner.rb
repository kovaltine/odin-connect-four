# frozen_string_literal: true

# determines if there is a winner
module Winner
  # do i only need two of these? yes i think so.
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

    p "positions of #{@player}: #{position}"
    # position should never be nil
    # return false if position[index].nil?

    DIAGONAL_PATTERNS.map do |prediction|
      next_position = position[index] # <-- starting point
      while position.include?(next_position)
        next_position = []
        # alter the coordinates according to one of the DIAGONAL_PATTERNS
        # break if position[index].nil?

        next_position.push(position[index][0] + prediction[1])
        next_position.push(position[index][1] + prediction[0])
        # if that coordinate is on the board, increment the counter
        p "prediction of the next point for #{@player}: #{next_position}"

        increment_counter?(position, next_position) ? counter += 1 : counter = 0

        puts "counter: #{counter}"
        return true if counter == 3

        index += 1
      end
    end
    false
  end

  # counter isn't incrementing properly
  # arr represents the positions that that player currently has
  def increment_counter(arr, curr_position)
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
