require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :cursor, :board
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def build_grid
        @board.rows.map.with_index{ |row, i| build_row(row, i) }
    end

    def build_row(row, i)
        row.map.with_index do |peice, j|
            background = colors_at(i, j)
            peice.to_s.colorize(background)
        end
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

    def render
        system("clear")
        pos = @cursor.cursor_pos
        "#{@board[pos]}".
    end
end