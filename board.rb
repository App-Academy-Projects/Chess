require_relative 'pieces'

SIZE = 8
COLORS = [:white, :black]

class Board
    attr_reader :rows
    def initialize
        @sentinel = NullPiece.instance
        @rows = Array.new(SIZE) { Array.new(SIZE, @sentinel) }

        COLORS.each do |color|
            fill_back_row(color)
            fill_pawns_row(color)
        end
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    def [](pos)
        raise 'invalid pos' unless valid_pos?(pos)

        i, j = pos
        @rows[i][j]
    end

    def []=(pos, piece)
        raise 'invalid pos' unless valid_pos?(pos)

        i, j = pos
        @rows[i][j] = piece
    end

    def empty?(pos)
        self[pos].empty?
    end

    def add_piece(piece, pos)
        raise "This position isn't empty" unless empty?(pos)

        self[pos] = piece
    end

    def pieces
        @rows.flatten.reject(&:empty?)
    end

    def dup
        new_board = Board.new

        pieces.each do |piece|
            (piece.class).new(piece.color, new_board, piece.pos)
        end
    end

    def find_king(color)
        king_pos = pieces.find { |piece| piece.color == color && piece.is_a?(King) }
        king_pos || (raise "King not found!")
    end

    def move_piece(color, start_pos, end_pos)
        raise "No piece in #{start_pos}" if empty?(start_pos)

        piece = self[start_pos]
        if piece.color != color
            raise "You can't control your opponents pieces!"
        elsif !piece.moves.include?(end_pos)
            raise "You can't move your piece to this position"
        elsif !piece.valid_moves.include?(end_pos)
            raise "Tou can't move into a check position"
        end

        move_piece!(color, start_pos, end_pos)
    end

    def move_piece!(color, start_pos, end_pos)
        piece = self[start_pos]
        raise "This piece doesn't move like this" unless piece.moves.include?(end_pos)
      
        self[end_pos] = piece
        self[start_pos] = sentinel
        piece.pos = end_pos
    end

    def other_color(color)
        :white == color ? :black : :white
    end

    def in_check?(color)
        king_pos = find_king(color)
        pieces.any? do |piece|
            piece.moves.include?(king_pos)
        end
        false
    end

    def checkmate?(color)
        return false unless in_check?(color)
        pieces.select { |p| p.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    private
    attr_reader :sentinel

    def fill_back_row(color)
        back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        i = color == :white ? 0 : 7
        back_pieces.each_with_index do |piece, j|
            piece.new(color, self, [i, j])
        end
    end

    def fill_pawns_row(color)
        i = color == :white ? 1 : 6
        8.times { |j| Pawn.new(color, self, [i, j]) }
    end
end