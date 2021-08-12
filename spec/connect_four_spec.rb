# frozen_string_literal: true

require_relative '../lib/connect_four'

# build connect four using test driven development

# instantiating the class creates an array
# describe 'create a game board' do
#   # 7 columns by 6 rows
#   let(:build_board) { ConnectFour.new }
#   it 'returns an array of 6 rows by 7 columns' do
#     expect(build_board.return_board.length).to eq(42)
#   end
# end

# determine the winner
describe 'check for a horizontal win' do
  context 'check for a horizontal win' do
    board = [[nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil],
             ['X', 'X', 'X', 'X', nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil]]
    let(:horizontal_win) { ConnectFour.new(board) }
    it 'returns true' do
      expect(horizontal_win.horizontal_wins?).to eq(true)
    end
  end
  context 'check for a horizontal win' do
    board = [[nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil],
             [nil, nil, 'X', 'X', 'X', 'X', nil],
             [nil, nil, nil, nil, nil, nil, nil],
             ['O', 'O', 'O', 'O', nil, nil, nil],
             [nil, nil, nil, nil, nil, nil, nil]]
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
    vertical_board = [[nil, nil, nil, nil, nil, 'O', nil],
                      [nil, nil, nil, nil, nil, 'O', nil],
                      [nil, 'X', nil, nil, nil, 'O', nil],
                      [nil, 'X', nil, nil, nil, 'O', nil],
                      [nil, 'X', nil, nil, nil, nil, nil],
                      [nil, 'X', nil, nil, nil, nil, nil]]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.vertical_wins?).to eq(true)
    end
  end
  context 'check for a vertical win' do
    vertical_board = [[nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil]]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.vertical_wins?).to eq(true)
    end
  end
  context 'check for no vertical win' do
    let(:vertical_win) { ConnectFour.new }
    it 'returns true' do
      expect(vertical_win.vertical_wins?).not_to eq(true)
    end
  end
end

describe 'check for a diagonal win' do
  context 'check for a right diagonal win' do
    diagonal_board = [[nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, 'X', nil, nil, nil],
                      [nil, nil, 'X', nil, nil, nil, nil],
                      [nil, 'X', nil, nil, nil, nil, nil],
                      ['X', nil, nil, nil, nil, nil, nil]]
    let(:diagonal_win) { ConnectFour.new(diagonal_board) }
    it 'returns true' do
      expect(diagonal_win.diagonal_wins?).to eq(true)
    end
  end
  context 'check for a left diagonal win' do
    diagonal_board = [[nil, nil, nil, nil, nil, nil, nil],
                      [nil, 'X', nil, nil, nil, nil, nil],
                      [nil, nil, 'X', nil, nil, nil, nil],
                      [nil, nil, nil, 'X', nil, nil, nil],
                      [nil, nil, nil, nil, 'X', nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil]]
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
    horizontal_board = [[nil, nil, nil, nil, nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil],
                        ['X', 'X', 'X', 'X', nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil]]
    let(:horizontal_win) { ConnectFour.new(horizontal_board) }
    it 'returns true' do
      expect(horizontal_win.check_winner?).to eq(true)
    end
  end
  context 'check for a vertical win' do
    vertical_board = [[nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, 'X', nil],
                      [nil, nil, nil, nil, nil, nil, nil],
                      [nil, nil, nil, nil, nil, nil, nil]]
    let(:vertical_win) { ConnectFour.new(vertical_board) }
    it 'returns true' do
      expect(vertical_win.check_winner?).to eq(true)
    end
  end
  context 'check for a diagonal win' do
    diagonal_board =   [[nil, nil, nil, nil, nil, nil, nil],
                        [nil, 'X', nil, nil, nil, nil, nil],
                        [nil, nil, 'X', nil, nil, nil, nil],
                        [nil, nil, nil, 'X', nil, nil, nil],
                        [nil, nil, nil, nil, 'X', nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil]]
    let(:diagonal_win) { ConnectFour.new(diagonal_board) }
    it 'returns true' do
      expect(diagonal_win.check_winner?).to eq(true)
    end
  end
end

# what's the next thing i need to test?
# how do i test the board being printed out properly?
# player input?
