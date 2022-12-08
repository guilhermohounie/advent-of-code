# frozen_string_literal: true

require_relative './solution'
require 'minitest/autorun'

# Solve the problem
class TestSolution < Minitest::Test
  def test_solution
    datastream_buffer = ParseDatastreamBuffer.new(File.join(__dir__, 'input.txt')).datastream_buffer

    solution = Subroutine.new(datastream_buffer)

    assert_equal 1804, solution.packet_marker
    assert_equal 2508, solution.message_marker
  end
end
