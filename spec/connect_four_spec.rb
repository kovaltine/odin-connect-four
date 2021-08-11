# frozen_string_literal: true

require_relative '../lib/connect_four'

# build connect four using test driven development

# instantiating the class creates an array
describe 'create a game board' do
  # 7 columns by 6 rows
  let(:build_board) { ConnectFour.new }
  it 'returns an array of 6 rows by 7 columns' do
    expect(build_board.return_board.length).to eq(42)
  end
end

# determine the winner
describe 'check for horizontal wins' do
  context 'check for horizontal wins' do
    board = %w[X X X X]
    let(:horizontal_row) { ConnectFour.new(board) }
    it 'returns true' do
      expect(horizontal_row.check_winner?).to eq(true)
    end
  end
  #   context 'check for vertical wins' do
  #     board = Array.new(42)
  #     board[0] = 'X'
  #     board[6] = 'X'
  #     board[12] = 'X'
  #     board[18] = 'X'
  #     let(:vertical_row) { ConnectFour.new(board) }
  #     xit 'returns true' do
  #       expect(vertical_row.check_winner?).to eq(true)
  #     end
  #   end
end

# describe 'check for vertical wins' do
#   context ''
# end
