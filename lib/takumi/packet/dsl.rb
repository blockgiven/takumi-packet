module Takumi
  module Packet
    module Dsl
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def field(name, type)
          fields << {name: name, type: type}
        end

        def fields
          @fields ||= []
        end

        def decode(packet)
          attrs = ::Takumi::Packet.decode(self, packet)
          new(attrs)
        end
      end

      def to_s
        ::Takumi::Packet.encode(self.class, self)
      end
    end
  end
end
