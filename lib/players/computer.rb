module Players
  class Computer < Player

    def move(board)
      #secure middle position early
      if board.turn_count == 0
        index = 4
      elsif board.turn_count == 1 && board.cells[4] == " "
        index = 4
      #secure corner early if middle position is taken
      elsif board.turn_count == 1 && board.cells[4] != " "
        index = [0,2,6,8].sample
      #check if there is a win opportunity
      elsif check_move_to_win?(board)
        index = move_to_win(board)
      #check if there is a block opportunity
      elsif check_move_to_block?(board)
        index = move_to_block(board)
      #random fallback move
      else
        index = random_move(board)
      end
      #increment to match user input (1-9) and convert to string
        index += 1
        index.to_s
    end


    def check_current_player(board)
      board.turn_count.even? ? "X" : "O"
    end

    def check_move_to_block?(board)
      if check_current_player(board) == "X"
        enemy_token = "O"
      else
        enemy_token = "X"
      end
      matches = []
      Game::WIN_COMBINATIONS.each do |combo|
        matches_token = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == enemy_token }
        matches_space = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == " " }
        #if a win combo is 75% filled for the enemy, record it in the matches array
        if matches_token.count == 2 && matches_space.count == 1
          matches << "match"
        end
      end
      matches.include?("match")
    end

    def move_to_block(board)
      if check_current_player(board) == "X"
        enemy_token = "O"
      else
        enemy_token = "X"
      end
      index = 0
      Game::WIN_COMBINATIONS.each do |combo|
        matches_token = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == enemy_token }
        matches_space = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == " " }
        if matches_token.count == 2 && matches_space.count == 1
          combo_index = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].index {|slot| slot == " "}
          index = combo[combo_index.to_i]
          break
        end
      end
      index
    end

    def random_move(board)
      indices = []
      board.cells.each_with_index do |slot, index|
        if slot == " "
          indices << index
        end
      end
      indices.sample
    end

    def check_move_to_win?(board)
      token_check = check_current_player(board)
      matches = []
      Game::WIN_COMBINATIONS.each do |combo|
        matches_token = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == token_check }
        matches_space = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == " " }
        #if a win combo is 75% filled for the current player, record it in the matches array
        if matches_token.count == 2 && matches_space.count == 1
          matches << "match"
        end
      end
      matches.include?("match")
    end

    def move_to_win(board)
      index = 0
      token_check = check_current_player(board)
      Game::WIN_COMBINATIONS.each do |combo|
        matches_token = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == token_check }
        matches_space = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].select {|slot| slot == " " }
        if matches_token.count == 2 && matches_space.count == 1
          combo_index = [board.cells[combo[0]], board.cells[combo[1]], board.cells[combo[2]]].index {|slot| slot == " "}
          index = combo[combo_index.to_i]
          break
        end
      end
      index
    end
  end
end
