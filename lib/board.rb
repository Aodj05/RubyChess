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
            [[0, :black], [7, :white]].each do |(row, color)|
                location = [row, column]
                board[location] = piece_klass.new(
                    board,
                    location,
                    color
                )
            end
        end
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

    def empty?(location)
        row, column = location
        grid[row][column] == NullPiece.instance
    end

    def move_piece(start_pos, end_pos)
        #Validate end position is in a safe move
        piece = self[start_pos]
        if !piece.safe_moves.include?(end_pos)
            raise InvalidMoveErr.new(
                "End position (#{end_pos}) not in available moves: #{piece.safe_moves}"
            )
        end
        if !in_bounds?(end_pos)
            raise InvalidMoveErr.new ('end position not in bounds')
        end
        move_piece!(start_pos, end_pos)
    end
    
end

