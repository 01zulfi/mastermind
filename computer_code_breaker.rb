# frozen_string_literal: true

require './hints'
require './display'

# game to play when computer is code breaker
class ComputerCodeBreaker
  include Hints
  include Display

  def initialize
    @code_breaker = 'Computer'
    @code_maker = 'Human'
    @code = code_from_terminal
    @cracked = nil
    @turn = 0
    @current_guess = '1122'
    @set = all_permutations
  end

  def start
    code_breaker_move
    if @turn >= 12
      puts_computer_could_not_solve
    else
      puts_computer_won(@code, @turn)
    end
  end

  private

  def code_breaker_move
    until @cracked
      break if @turn >= 12

      @turn += 1
      current_hint = hints(@code, @current_guess)
      puts_current_guess(@current_guess)
      puts_hints(current_hint)
      @set = @set.select { |element| keep_element(current_hint, hints(@code, element)) }
      @current_guess = @set.empty? ? @current_guess : @set[0]
      @cracked = true if @code == @current_guess
    end
  end

  def keep_element(current_hint, hint)
    current_weigth = current_hint[:correct] * 2 + current_hint[:close]
    weigth = hint[:correct] * 2 + hint[:close]
    weigth > current_weigth
  end

  def all_permutations
    [1, 2, 3, 4, 5, 6].repeated_permutation(4).map(&:join)
  end

  def code_from_terminal
    code = ''
    first_try = true
    until valid_code(code)
      first_try ? puts_prompt_for_code_breaker : puts_prompt_for_code_breaker_invalid
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
end
