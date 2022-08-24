class Piece
    attr_reader :color, :board

    def initialize(board, color, location)
        @board = board
        @color = color
        @location = location
    end

    def enemy?(location)
        board.in_bounds?(location) && board[location].color != color
    end
    
end