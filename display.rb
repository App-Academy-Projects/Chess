require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :cursor, :board
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def colors_at(i, j)
        pos = cursor.cursor_pos
        if pos == [i, j] && cursor.selected
            background = :light_green
        elsif pos == [i, j]
            background = :light_red
        elsif (i+j).even?
            background = :black
        else
            background = :white
        end
    end
end