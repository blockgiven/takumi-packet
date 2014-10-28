module Takumi
  module Packet
    class Varint
      class << self
        def decode(source)
          int = 0
          source.chars.each.with_index(1) do |char, index|
            byte = char.ord
            int <<= 7
            int += byte & 0b111_1111

            return int, index if (byte & 0b1000_0000).zero?
          end
        end
      end

      def initialize(int)
        @int = int
      end

      def to_s
        packet = "".encode(Encoding::BINARY)
        int = @int
        loop do
          bits = int & 0b111_1111
          int = int >> 7

          if int.zero?
            packet << bits.chr and break
          else
            packet << (bits | 0b1000_0000).chr
          end
        end
        packet
      end
    end
  end
end
