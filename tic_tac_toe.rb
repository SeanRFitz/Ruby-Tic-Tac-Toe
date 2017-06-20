# tic tac toe game

def display_board(board_arr)
	puts "\t  " + "1|2|3"
	puts "\t1 " + board_arr[0].join("|")
	puts "\t  " + "-" * 5
	puts "\t2 " + board_arr[1].join("|")
	puts "\t  " + "-" * 5
	puts "\t3 " + board_arr[2].join("|")
end


def pick_a_square(cur_board)
	puts "Pick the row number and column number for your square: "
	square = gets.chomp
	if cur_board[square[0].to_i-1][square[1].to_i-1] == " "
		if  (/^[1-3][1-3]$/).match(square)
			return square
		else
			puts "That is not valid: Try a number combo like '22'."
		end
	end
	pick_a_square(cur_board)
end


def update_board(chosen_square,cur_board,turn)
	if turn % 2 == 0
		marker = "O"
	else
		marker = "X"
	end
	cur_board[chosen_square[0].to_i-1][chosen_square[1].to_i-1] = marker
	cur_board
end

def win?(cur_board)
	for i in (0..2)
		# rows
		if cur_board[i].join == "XXX" || cur_board[i].join == "OOO"
				return true
		end

		# columns
		col_result = ""
		for j in (0..2)
			col_result += cur_board[j][i]
			if col_result == "XXX" || col_result == "OOO"
				return true
			end
		end
	end

	# top-left to bottom-right diagonal
	diag_result = ""
	diag_result += cur_board[0][0]
	diag_result += cur_board[1][1]
	diag_result += cur_board[2][2]
	if diag_result == "XXX" || diag_result == "OOO"
		return true
	end

	# top-right to bottom-left diagonal
	diag_result = ""
	diag_result += cur_board[0][2]
	diag_result += cur_board[1][1]
	diag_result += cur_board[2][0]
	if diag_result == "XXX" || diag_result == "OOO"
		return true
	end
	false
end


def restart?
	puts "Do you want to play again? (y/n)"
	again = gets.chomp.downcase
	if again == "y"
		return true
	end
	false
end


board = [[" "," "," "],[" "," "," "],[" "," "," "]]
turn_num = 0
game_over = false
while true
	# Set the turn number and display the board
	turn_num += 1
	display_board(board)

	# Ask for the player to pick a square
	a = pick_a_square(board)

	# Update the board
	board = update_board(a,board,turn_num)
	
	# Did someone win?
	if win?(board)
		display_board(board)
		winner = turn_num % 2 == 0 ? "2" : "1"
		puts "Congratulations to Player #{winner}! You won!"
		game_over = true
	elsif turn_num == 9
		display_board(board)
		puts "You tied!"
		game_over = true
	end

	# Play again?
	if game_over
		if restart?
			board = [[" "," "," "],[" "," "," "],[" "," "," "]]
			turn_num = 0
			game_over = false
		else
			break
		end
	end
end