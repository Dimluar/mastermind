# frozen_string_literal: true

# Give clues by testing guess
module CodeTest
  def compare_result(code, option)
    clues = [0, 0]
    code.uniq.each do |value|
      index_code = index_all(code, value)
      index_option = index_all(option, value)
      clues = compare_index(index_code, index_option, clues) unless index_option.empty?
    end
    clues
  end

  private

  def index_all(array, value)
    array.each_index.each_with_object([]) do |index, all_index|
      all_index << index if array[index] == value
      all_index
    end
  end

  def compare_index(index_code, index_option, clues)
    length_option = index_option.length
    length_code = index_code.length
    wrong_position = (index_option - index_code).length
    correct_position = length_option - wrong_position
    wrong_position = length_code - correct_position if length_option > length_code
    clues[0] += correct_position
    clues[1] += wrong_position
    clues
  end
end
