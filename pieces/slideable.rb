HORIZONTAL_AND_VERTICAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

module Slideable
    def horizontal_and_vertical_dirs
        HORIZONTAL_AND_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def move_dirs
        # Each Subclass should implement this method!
        raise NotImplementedError
    end

    def moves
        moves = []

        move_dirs.each do |dx, dy|
            moves += grow_unblocked_moves_in_dir(dx, dy)
        end
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        pos_x, pos_y = pos

        while true
            pos_x, pos_y = pos_x + dx, pos_y + dy
            pos = [pos_x, pos_y]

            break unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            elsif board[pos].color != color
                moves << pos
                break
            end
        end
        moves
    end
end