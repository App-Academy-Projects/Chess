class Piece
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end
    
    def to_s
        "#{symbol}"
    end

    def symbol
        # Each Subclass should implement this method!
        raise NotImplementedError
    end
end