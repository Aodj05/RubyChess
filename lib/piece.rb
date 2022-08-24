class Piece
    attr_reader :color, :board
    attr_accessor :location

    def initialize(board, location, color)
        @board = board
        @color = color
        @location = location
    end

    def enemy?(location)
        board.in_bounds?(location) && board[location].color != color
    end
    
end