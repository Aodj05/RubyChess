class Board
    def initialize
        @grid = [
            ["X", "X", nil, "X"],
            ["X", "X", nil, "X"],
            ["X", "X", nil, "X"],
            ["X", "X", nil, "X"]
        ]
    end

    def place(piece, row, column)
        @grid[row][column] = piece
    end
    
end