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

    def forward_steps
        i, j = pos
        one_stp = [i + forward_dir, j]
        return [] unless board.valid_pos?(one_stp) && board.empty?(one_stp)

        steps = [one_stp]
        two_stp = [i + 2 * forward_dir, j]
        steps << two_stp if at_start_row? && board.empty(two_stp)
        steps
    end
end