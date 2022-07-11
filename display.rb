# frozen_string_literal: true

# module for display methods
module Display
  def puts_intro_and_rules
    puts 'Welcome to Mastermind!'
    puts "Here's how it's played: "
    puts 'A player sets a code, while the other takes guesses to crack that code.'
    puts "After each guess, hints are returned to indicate how 'close' the guess was to the code."
    puts 'Code is a 4 digit combination of numbers from 1 to 6 e.g. 6251.'
    puts ''
    puts ''
    puts ''
  end

  def puts_initial_prompt
    puts 'Who do you want to play as?'
    puts 'Enter 1 to play as Code Breaker'
    puts 'Enter 2 to play as Code Maker'
    puts ''
  end

  def puts_make_your_move
    puts 'Make your move!'
    puts ''
  end

  def puts_invalid_made_your_move
    puts ''
    puts 'Invalid, make your move!'
    puts ''
  end

  def puts_player_won(player_name)
    puts "#{player_name} won"
  end

  def puts_player_out_of_moves
    puts 'Out of moves, computer won.'
  end

  def puts_turn(turn)
    puts ''
    puts "Turn #{turn}"
    puts ''
  end

  def puts_hints(hints)
    puts ''
    puts "Correct: #{hints[:correct]}"
    puts "Close: #{hints[:close]}"
    puts ''
  end

  def puts_computer_could_not_solve
    'Computer could not solve in 12 turns.'
  end

  def puts_computer_won(code, turns)
    puts ''
    puts "Computer won: code is #{code}"
    puts "Computer solved in #{turns} turns"
    puts ''
  end

  def puts_current_guess(current_guess)
    puts ''
    puts "Computer's current guess: #{current_guess}"
    puts ''
  end

  def puts_prompt_for_code_breaker
    puts 'Enter a code for computer to break:'
  end

  def puts_prompt_for_code_breaker_invalid
    puts 'Invalid code, enter again:'
  end
end
