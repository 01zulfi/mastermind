# frozen_string_literal: true

require './display'
require './hints'

# Game to play when human is the codebreaker loop
class HumanCodeBreaker
  include Display
  include Hints

  def initialize
    @code_breaker = 'Human'
    @code_maker = 'Computer'
    @code = random_code
    @cracked = nil
    @turn = 1
  end

  def start
    code_breaker_move until game_end?
    if @cracked
      put_player_won(@code_breaker)
    else
      puts_player_out_of_moves
    end
  end

  private

  def random_code
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].join
  end

  def code_breaker_move
    puts_turn(@turn)
    @turn += 1
    move = code_breaker_move_from_terminal
    if move == @code
      @cracked = true
    else
      @cracked = false
      puts puts_hints(hints(@code, move))
    end
  end

  def code_breaker_move_from_terminal
    move = ''
    first_move = true
    until valid_move(move)
      first_move ? puts_make_your_move : puts_invalid_made_your_move 
      move = gets.chomp
      first_move = false
    end
    move
  end

  def valid_move(move)
    correct_length = move.length == 4
    only_integers = move.scan(/\D/).empty?
    correct_integers = move.split('').map(&:to_i).all? { |integer| integer.between?(1, 6) }

    correct_length && only_integers && correct_integers
  end

  def game_end?
    @cracked || @turn >= 12
  end
end
