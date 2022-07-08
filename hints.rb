# frozen_string_literal: true

# module for hints method
module Hints
  # class to hide helper methods
  class HintsCalculator
    def calculate_hints(code, move)
      code_array = convert_string_to_array(code)
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

    private

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

    def convert_string_to_array(string)
      string.split('').map(&:to_i)
    end
  end

  def hints(code, move)
    HintsCalculator.new.calculate_hints(code, move)
  end
end
