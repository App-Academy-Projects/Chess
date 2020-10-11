SIZE = 8

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(SIZE) { Array.new(SIZE, nil) }
        @sentinel = NullPiece
    end
end