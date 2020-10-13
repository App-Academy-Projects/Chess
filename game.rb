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
        @cur_player = :white
    end

    def play
        until board.checkmate?(cur_player)
            begin
                start_pos, end_pos = players[cur_player].make_move(board)
                board.move_piece(cur_player, start_pos, end_pos)
                swap_turn!
                notify_players
            rescue => exception
                puts exception
                retry
            end
            puts "#{cur_player} is checkmated!"
        end
    end
end