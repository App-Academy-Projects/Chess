require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :cursor, :board, :notifications
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
        @notifications = {}
    end

    def build_grid
        @board.rows.map.with_index{ |row, i| build_row(row, i) }
    end

    def build_row(row, i)
        row.map.with_index do |peice, j|
            background = colors_at(i, j)
            peice.to_s.colorize(:background => background)
        end
    end

    def colors_at(i, j)
        pos = cursor.cursor_pos
        if pos == [i, j] && cursor.selected
            background = :light_green
        elsif pos == [i, j]
            background = :light_red
        elsif (i+j).even?
            background = :light_black
        else
            background = :light_yellow
        end
    end

    def reset!
        @notifications.delete(:error)
    end

    def uncheck!
        @notifications.delete(:check)
    end

    def set_check!
        @notifications[:check] = "Check!"
    end

    def render
        system("clear")
        build_grid.each { |row| puts row.join }
        @notifications.each do |_key, val|
            puts val
        end
    end
end