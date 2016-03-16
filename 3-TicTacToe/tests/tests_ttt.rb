require "./board.rb"
require "test/unit"

class TestBoard < Test::Unit::TestCase
  
  def test_no_lines_on_new_board
    a = Board.new
    assert_false a.line_in_row?
    assert_false a.line_in_col? 
    assert_false a.line_in_diag?
  end
  
  def test_can_check_row_of_X
    a = Board.new
    a.update_board([0,0], "X")
    a.update_board([0,1], "X")
    a.update_board([0,2], "X")
    
    assert_true a.line_in_row?
    assert_true a.has_a_line?
  end
  
  def test_can_check_row_of_O
    a = Board.new
    a.update_board([0,0], "O")
    a.update_board([0,1], "O")
    a.update_board([0,2], "O")
    
    assert_true a.line_in_row?
    assert_true a.has_a_line?
  end
  
  def test_no_false_positives_on_rows
    a = Board.new
    a.update_board([1,0], "O")
    a.update_board([1,1], "X")
    a.update_board([1,2], "O")
    
    assert_false a.line_in_row?
    assert_false a.has_a_line?
  end
  
  def test_can_check_col_of_X
    a = Board.new
    a.update_board([0,0], "X")
    a.update_board([1,0], "X")
    a.update_board([2,0], "X")
    
    assert_true a.line_in_col?
    assert_true a.has_a_line?
  end
  
  def test_can_check_col_of_O
    a = Board.new
    a.update_board([0,2], "O")
    a.update_board([1,2], "O")
    a.update_board([2,2], "O")
    
    assert_true a.line_in_col?
    assert_true a.has_a_line?
  end
  
  def test_can_check_diag_of_O
    a = Board.new
    a.update_board([0,2], "O")
    a.update_board([1,1], "O")
    a.update_board([2,0], "O")
    puts ""
    a.show_board
    
    assert_true a.has_a_line?
    assert_true a.line_in_diag?
  end
  
  def test_can_check_diag_of_X
    a = Board.new
    a.update_board([0,0], "X")
    a.update_board([1,1], "X")
    a.update_board([2,2], "X")
    puts ""
    a.show_board
    
    assert_true a.has_a_line?
    assert_true a.line_in_diag?
  end
  
    def test_no_false_positives_on_diags
    a = Board.new
    a.update_board([0,0], "O")
    a.update_board([1,1], "X")
    a.update_board([2,2], "O")
    
    assert_false a.line_in_diag?
    assert_false a.has_a_line?
  end
end