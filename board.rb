require_relative 'null_piece'

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