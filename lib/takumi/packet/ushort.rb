module Takumi
  module Packet
    class Ushort
      class << self
        def decode(source)
          return source[0..1].unpack("n"), 2
        end
      end

      def initialize(ushort)
        @ushort = ushort
      end

      def to_s
        [@ushort].pack("n")
      end
    end
  end
end
