require_relative 'board'

class Game
    attr_reader :board, :display, :white_player, :black_player, :cur_player
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @white_player = HumanPlayer.new(:white, @display)
        @black_player = HumanPlayer.new(:black, @display)
        @cur_player = white_player
    end
end