module Stepable
    def moves
        moves = []

        move_diffs.each do |dx, dy|
            pos_x, pos_y = pos
            pos = [pos_x + dx, pos_y + dy]

            next unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            elsif board[pos].color != color
                moves << pos
            end
        end
        
        moves
    end

    private

    def move_diffs
        # Each Subclass should implement this method!
        raise NotImplementedError
    end
end