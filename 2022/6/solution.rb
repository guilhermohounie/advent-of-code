# frozen_string_literal: true

# Parse the datastream buffer
class ParseDatastreamBuffer
  attr_reader :datastream_buffer

  def initialize(path)
    @datastream_buffer = File.read(path)
  end
end

# Subroutine
class Subroutine
  attr_reader :packet_marker, :message_marker

  def initialize(datastream_buffer)
    @packet_marker = start_of_packet_marker(datastream_buffer)
    @message_marker = start_of_message_marker(datastream_buffer)
  end

  def start_of_packet_marker(datastream_buffer)
    count = 0
    datastream_buffer.split('').each_with_index do |_char, index|
      chunks_of_four = datastream_buffer[index..index + 3]
      if chunks_of_four.chars.uniq.length == 4
        count += 4
        break
      end
      count += 1
    end
    count
  end

  def start_of_message_marker(datastream_buffer)
    count = 0
    datastream_buffer.split('').each_with_index do |_char, index|
      chunks_of_fourteen = datastream_buffer[index..index + 13]
      if chunks_of_fourteen.chars.uniq.length == 14
        count += 14
        break
      end
      count += 1
    end
    count
  end
end
