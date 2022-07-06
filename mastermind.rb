# frozen_string_literal: true

require 'pry-byebug'

# for display methods
module Display
  def puts_player_won(player_name)
    puts "#{player_name} won"
  end

  def puts_player_out_of_moves
    puts 'Out of moves, computer won.'
  end

  def puts_turn(turn)
    puts "Turn #{turn}"
  end
end

# Game to play when human is the codebreaker loop
class HumanAsCodeBreaker
  include Display

  def initialize
    @player = 'Human'
    @code = random_code
    @cracked = nil
    @turn = 1
  end

  def start
    code_breaker_move until game_end?
    if @cracked
      puts_player_won(@player.name)
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
    puts @code
    move = codebreaker_move
    if move == @code
      @cracked = true
    else
      @cracked = false
      puts calculate_hints(move)
    end
  end

  def codebreaker_move
    move = ''
    first_move = true
    until valid_move(move)
      puts first_move ? 'Make your move!' : 'Invalid, make your move!'
      move = gets.chomp
      first_move = false
    end
    move
  end

  def valid_move(move)
    move.length == 4 && move.scan(/\D/).empty?
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

# Game to play when human is the codemaker
class HumanAsCodeMaker
  include Display

  def initialize
    @player = 'Computer'
    @code = codemaker_move
    @cracked = nil
    @turn = 1
  end

  def start
    code_breaker_move until game_end?
    if @cracked
      puts_player_won(@player)
    else
      puts_player_out_of_moves
    end
  end

  private

  def code_breaker_move
    @turn += 1
    if '0000'  == @code
      @cracked = true
    else
      @cracked = false
    end
  end

  def codemaker_move
    move = ''
    first_move = true
    until valid_move(move)
      puts first_move ? 'Create a code!' : 'Invalid, create a code!'
      move = gets.chomp
      first_move = false
    end
    move
  end

  def valid_move(move)
    move.length == 4 && move.scan(/\D/).empty?
  end

  def game_end?
    @cracked || @turn >= 12
  end
end

# Game
class Game
  def initialize
    @game_mode = game_mode_selection
  end

  def start
    if @game_mode == '1'
      HumanAsCodeBreaker.new.start
    else
      HumanAsCodeMaker.new.start
    end
  end

  private

  def game_mode_selection
    puts 'Who do you want to play as?'
    puts 'Enter 1 for Code Breaker'
    puts 'Enter 2 for Code Maker'

    selection = ''
    selection = gets.chomp until valid_selection(selection)
    selection
  end

  def valid_selection(selection)
    %w[1 2].include?(selection)
  end
end

mastermind = Game.new
mastermind.start
