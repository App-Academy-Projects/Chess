require_relative 'board'

class Game
    attr_reader :board, :display, :players, :cur_player
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { 
            white: HumanPlayer.new(:white, @display),
            black: HumanPlayer.new(:black, @display)
        }
        @cur_player = @players[:white]
    end


end