class Board
    def initialize(size)
        @rows = Array.new(size) { Array.new(size, nil) }
        @sentinel = NullPeice
    end
end