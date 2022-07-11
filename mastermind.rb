# frozen_string_literal: true

require './display'
require './human_code_breaker'
require './computer_code_breaker'

# Game
class Game
  include Display

  def initialize
    puts_intro_and_rules
    @game_mode = game_mode_selection
  end

  def start
    if @game_mode == '1'
      HumanCodeBreaker.new.start
    else
      ComputerCodeBreaker.new.start
    end
  end

  private

  def game_mode_selection
    puts_initial_prompt

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
