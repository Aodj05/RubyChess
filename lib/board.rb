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
        board
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

    def in_check?(color)
        king = pieces.find {|p| p.color == color && p.is_a?(King)}

        if king.nil?
            raise 'No king here'
        end

        king_pos = king.location

        # loop over every piece of the opposite color
        pieces.select {|p| p.color != color}.each do |piece|
            #if a piece has an available move in that position
            #of the king with that color, then color is in check
            if piece.available_moves.include?(king_pos)
                return true
            end
        end
        false
    end

    def checkmate?(color)
        return false if !in_check?(color)
        color_pieces = pieces.select {|p| p.color == color }
        color_pieces.all? {|piece| piece.safe_moves.empty? }
    end

    def pieces
        grid.flatten.reject {|piece| piece.is_a?(NullPiece) }
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

    def move_piece!(start_pos, end_pos)
        # remove piece from board at current position
        #place piece on board at new position
        self[start_pos], self[end_pos] = NullPiece.instance, self[start_pos]

        # update piece's position with end position
        self[end_pos].location = end_pos
    end
    

    def dup
        new_board = Board.new
        pieces.each do |piece|
            new_piece = piece.class.new(
                new_board,
                piece.location,
                piece.color
            )
            new_board[new_piece.location] = new_piece
        end
        new_board
    end
end

