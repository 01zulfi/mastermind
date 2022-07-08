# frozen_string_literal: true

require './hints'

# game to play when computer is code breaker
class ComputerCodeBreaker
  include Hints

  def initialize
    @code_breaker = 'Computer'
    @code_maker = 'Human'
    @code = code_from_terminal
    @cracked = nil
    @turn = 0
  end

  def start
    code_breaker_move until game_end?
  end

  private

  def code_breaker_move
  end

  def code_from_terminal
    code = ''
    first_try = true
    until valid_code(code)
      puts first_try ? 'Enter a code for computer to break': 'Invalid, enter again'
      code = gets.chomp
      first_try = false
    end
    code
  end

  def valid_code(code)
    correct_length = code.length == 4
    only_integers = code.scan(/\D/).empty?
    correct_integers = code.split('').map(&:to_i).all? { |integer| integer.between?(1, 6) }

    correct_length && only_integers && correct_integers
  end

  def game_end?
    @cracked || @turn >= 12
  end
end
