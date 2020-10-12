require_relative 'piece'


class Pawn < Piece
    def symbol
        '♟'.colorize(color)
    end

    def move_dirs
        forward_steps + side_attacks
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

    def side_attacks
        i, j = pos

        side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]
        selected_moves = []
        side_moves.each do |new_pos|
            next false unless board.valid_pos?(new_pos)
            next false if board.empty?(new_pos)

            attacked_piece = board[new_pos]
            selected_moves << new_pos if attacked_piece && attacked_piece.color != color
        end
        selected_moves
    end
end