class Board
    attr_reader :grid

    def self.start_game
        board = self.new
        8.times do |c|
            board[[1, c]] = Pawn.new(board, [1, c], :black)
            board[[6, c]] = Pawn.new(board, [6, c], :white)
        end

        [Rook, Knight, Bishop, Queen, King, Bishop, Knight,
        Rook].each_with_index do |piece_klass, column|
    end


    def initialize
       @grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    end

    def []=(location, piece)
        row, column = location
        grid[row][column] = piece
    end

    def [](location)
        row, column = location
        grid[row][column]
    end

    def in_bounds?(location)
        row, column = location

        row < grid.length &&
        column < grid.first.length &&
        row >= 0 &&
        column >= 0
    end
end

