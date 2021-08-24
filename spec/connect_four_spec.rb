# frozen_string_literal: true

require_relative '../lib/connect_four'
require_relative '../lib/winner'
require 'colorize'

# determine the winner
describe 'check for a horizontal win' do
  context 'check for a horizontal win' do
    board = [['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), '.', '.', '.']]
    let(:horizontal_win) { ConnectFour.new(board) }
    it 'returns true' do
      expect(horizontal_win.horizontal_wins?).to eq(true)
    end
  end
  context 'check for a horizontal win' do
    board = [['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['.', '.', '.', '.', '.', '.', '.'],
             ['X'.colorize(:light_blue), 'X'.colorize(:light_blue), 'X'.colorize(:light_blue),
              'X'.colorize(:light_blue), '.', '.', '.'],
             ['O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), '.', '.', '.']]
    let(:horizontal_win) { ConnectFour.new(board) }
    it 'returns true' do
      expect(horizontal_win.horizontal_wins?).to eq(true)
    end
  end
  context 'check for no horizontal win' do
    let(:horizontal_win) { ConnectFour.new }
    it 'returns false' do
      expect(horizontal_win.horizontal_wins?).not_to eq(true)
    end
  end
end

describe 'check for a vertical win' do
  context 'check for a vertical win' do
    vertical_board = [['.', '.', '.', '.', 'O'.colorize(:red), '.'],
                      ['.', '.', '.', '.', 'O'.colorize(:red), '.'],
                      ['.', 'X'.colorize(:light_blue), '.', '.', 'O'.colorize(:red), '.', '.'],
                      ['.', 'X'.colorize(:light_blue), '.', '.', 'O'.colorize(:red), '.', '.'],
                      ['.', 'X'.colorize(:light_blue), '.', '.', '.', '.', '.'],
                      ['.', 'X'.colorize(:light_blue), '.', '.', '.', '.', '.']]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.vertical_wins?).to eq(true)
    end
  end
  context 'check for a vertical win' do
    vertical_board = [['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.']]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.vertical_wins?).to eq(true)
    end
  end
  context 'check for no vertical win' do
    let(:vertical_win) { ConnectFour.new }
    it 'returns false' do
      expect(vertical_win.vertical_wins?).not_to eq(true)
    end
  end
end

describe 'check for a diagonal win' do
  context 'check for a right diagonal win' do
    diagonal_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', 'O'.colorize(:red), '.', '.', '.'],
                      ['.', '.', 'O'.colorize(:red), '.', '.', '.', '.'],
                      ['.', 'O'.colorize(:red), '.', '.', '.', '.', '.'],
                      ['O'.colorize(:red), '.', '.', '.', '.', '.', '.']]
    let(:diagonal_win) { ConnectFour.new(diagonal_board) }
    it 'returns true' do
      expect(diagonal_win.diagonal_wins?).to eq(true)
    end
  end
  context 'check for a left diagonal win' do
    diagonal_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', 'O'.colorize(:red), '.', '.', '.', '.', '.'],
                      ['.', '.', 'O'.colorize(:red), '.', '.', '.', '.'],
                      ['.', '.', '.', 'O'.colorize(:red), '.', '.', '.'],
                      ['.', '.', '.', '.', 'O'.colorize(:red), '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.']]
    let(:diagonal_win) { ConnectFour.new(diagonal_board) }
    it 'returns true' do
      expect(diagonal_win.diagonal_wins?).to eq(true)
    end
  end
  context 'check for no diagonal win' do
    let(:diagonal_win) { ConnectFour.new }
    it 'returns true' do
      expect(diagonal_win.diagonal_wins?).not_to eq(true)
    end
  end
end

describe 'check for any win using check_winner?' do
  context 'check for any win using check_winner?' do
    let(:no_win) { ConnectFour.new }
    it 'returns false' do
      expect(no_win.check_winner?).to eq(false)
    end
  end
  context 'check for a horizontal win' do
    horizontal_board = [['.', '.', '.', '.', '.', '.', '.'],
                        ['.', '.', '.', '.', '.', '.', '.'],
                        ['.', '.', '.', '.', '.', '.', '.'],
                        ['.', '.', '.', '.', '.', '.', '.'],
                        ['O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), 'O'.colorize(:red), '.', '.', '.'],
                        ['.', '.', '.', '.', '.', '.', '.']]
    let(:horizontal_win) { ConnectFour.new(horizontal_board) }
    it 'returns true' do
      expect(horizontal_win.check_winner?).to eq(true)
    end
  end
  context 'check for a vertical win' do
    vertical_board = [['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', 'O'.colorize(:red)],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.']]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.check_winner?).to eq(true)
    end
  end
  context 'check for a diagonal win' do
    diagonal_board =   [['.', '.', '.', '.', '.', '.', '.'],
                        ['.', 'O'.colorize(:red), '.', '.', '.', '.', '.'],
                        ['.', '.', 'O'.colorize(:red), '.', '.', '.', '.'],
                        ['.', '.', '.', 'O'.colorize(:red), '.', '.', '.'],
                        ['.', '.', '.', '.', 'O'.colorize(:red), '.', '.'],
                        ['.', '.', '.', '.', '.', '.', '.']]
    let(:diagonal_win) { ConnectFour.new(diagonal_board) }
    it 'returns true' do
      expect(diagonal_win.check_winner?).to eq(true)
    end
  end
end

describe 'check for a draw using check_draw?' do
  context 'check for a draw using check_draw?' do
    tie_game = [
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X]
    ]
    let(:draw_game) { ConnectFour.new(tie_game) }
    it 'returns true' do
      expect(draw_game.check_draw?).to eq(true)
    end
  end
  context 'check for no draw using check_draw?' do
    no_tie = [
      %w[X X X X X X .],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X],
      %w[X X X X X X X]
    ]
    let(:no_draw_game) { ConnectFour.new(no_tie) }
    it 'returns false' do
      expect(no_draw_game.check_draw?).not_to eq(true)
    end
  end
end
