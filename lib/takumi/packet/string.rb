module Takumi
  module Packet
    class String
      class << self
        def decode(source)
          size, read = ::Takumi::Packet::Varint.decode(source)
          return source[read, size], (size + read)
        end
      end

      def initialize(str)
        @str = str
      end

      def to_s
        packet = "".encode(Encoding::BINARY)
        packet << ::Takumi::Packet::Varint.new(@str.bytesize).to_s
        packet << @str.dup.force_encoding(Encoding::BINARY)
      end
    end
  end
end
