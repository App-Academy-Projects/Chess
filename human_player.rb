require_relative 'display'
require_relative 'player'

class HumanPlayer < Player
    def make_move(board)
        start_pos, end_pos = nil, nil

        until start_pos && end_pos
            display.render

            if start_pos
                prompt_input
                end_pos = display.cursor.get_input
                display.reset! if end_pos
            else
                prompt_input
                start_pos = display.cursor.get_input
                display.reset! if start_pos
            end
        end

        [start_pos, end_pos]
    end

    def prompt_input
        puts "It's #{color}'s turn!"
        puts "Enter a move"
    end
end