# frozen_string_literal: true

require 'pry-byebug'

def random_code
  [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].join
end

# CodeBreaker class
class CodeBreaker
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# Game loop
class Game
  def initialize
    @player = CodeBreaker.new('human')
    @code = random_code
    @cracked = nil
    @turn = 0
  end

  def start
    code_breaker_move until game_end?
    if @cracked
      puts "#{@player.name} won."
    else
      puts 'Out of moves, computer won.'
    end
  end

  private

  def code_breaker_move
    @turn += 1
    puts @code
    move = gets.chomp
    if move == @code
      @cracked = true
    else
      @cracked = false
      puts calculate_hints(move)
    end
  end

  def calculate_hints(move)
    code_array = convert_string_to_array(@code)
    move_array = convert_string_to_array(move)

    hints = { correct: 0, close: 0 }

    common_values = common_values_in_two_arrays(code_array, move_array)

    common_values.each do |common_value|
      indices_in_code = indices(code_array, common_value)
      indices_in_move = indices(move_array, common_value)
      calculate_hints_helper(hints, indices_in_code, indices_in_move)
    end
    hints
  end

  def calculate_hints_helper(hints, indices_in_code, indices_in_move)
    if indices_in_code == indices_in_move
      hints[:correct] += indices_in_code.length
    else
      common_indices = common_values_in_two_arrays(indices_in_code, indices_in_move)
      hints[:correct] += common_indices.length
      hints[:close] += [indices_in_code, indices_in_move].min_by(&:size).length - common_indices.length
      hints[:close] = 0 if (hints[:close]).negative?
    end
  end

  def indices(array, element)
    array.each_index.select { |index| array[index] == element }
  end

  def common_values_in_two_arrays(array_one, array_two)
    array_one & array_two
  end

  def game_end?
    @cracked || @turn >= 12
  end

  def convert_string_to_array(string)
    string.split('').map(&:to_i)
  end
end

mastermind = Game.new
mastermind.start
