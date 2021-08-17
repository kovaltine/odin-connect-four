# frozen_string_literal: true

require './connect_four'

module Display
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
end
