class Knight

    def to_s
        color == :black ? "♞" : "♘"
    end
    
    def method_name
        [
            [1, 2],
            [2, 1],
            [-1, 2],
            [-2, 1],
            [1, -2],
            [2, -1],
            [-1, -2],
            [-2, -1],
        ]
    end
end