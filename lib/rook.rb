class Rook < Piece

    def to_s
        color == :black ? "♜" : "♖"
    end

    def moves_dirs
        [
            [0, 1],
            [0, -1],
            [1, 0],
            [-1, 0]
        ]
    end
end