class Game
    attr_reader :player1, :player2, :board, :renderer
    attr_accessor :current_player

    def initialize(board, player1, player2, renderer_class)
        @board = board
        @renderer = renderer_class.new(board)
        @player1 = player1
        @player2 = player2
        @current_player = @player1
    end

    def swap_player!
        self.current_player = (current_player == player1 ? player2 : player1)
    end

    def play
        while !over?
            renderer.render
            puts "it's #{current_player.color}'s turn"
            if board.in_check?(current_player.color)
                puts "#{current_player.color} is in check"
            end

            take_turn
            swap_player!
        end

        swap_player!
        puts "Game over! #{current_player.color} wins"
        renderer.render
    end

    def over?
        board.checkmate?(current_player.color)
    end
    

    def take_turn
        start_pos = nil
        # Prompt current player to enter a start position
        loop do
            puts "Choose your piece: "
            start_pos = current_player.get_pos
            if board[start_pos].color == current_player.color
                break
            end
            puts "Did not choose a #{current_player.color} piece"
        end

        # Prompt current player to enter an ending spot
        loop do
            puts "Select a spot to move to: "
            end_pos = current_player.get_pos

        # Move the piece
            begin
                board.move_piece(start_pos, end_pos)
                break
            rescue InvalidMoveErr => e
                puts e.message
            end
        end
    end
end