# frozen_string_literal: true

# module for display methods
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
