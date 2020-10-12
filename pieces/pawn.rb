require_relative 'piece'


class Pawn < Piece
    def symbol
        '♟'.colorize(color)
    end

    private

    def at_start_row?
        if :white == color
            pos[0] == 6
        else
            pos[0] == 1
        end
    end

    def forward_dir
        color == :white ? 1 : -1
    end
end