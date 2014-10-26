module Takumi
  module Packet
    class UnknownField < StandardError; end

    module_function

    def decode(packet_type, packet)
      packet_size, read = Packet::Varint.decode(packet)
      packet = packet[read, packet_size]

      fields = {}
      packet_type.fields.each do |field|
        case field[:type]
        when :varint
          data, read = ::Takumi::Packet::Varint.decode(packet)
        when :string
          data, read = ::Takumi::Packet::String.decode(packet)
        when :ushort
          data, read = ::Takumi::Packet::Ushort.decode(packet)
        else
          raise ::Takumi::Packet::UnknownField, field.inspect
        end
        fields[field[:name]] = data
        packet = packet[read..-1]
      end
      fields
    end

    def encode(packet_type, object)
      packet = "".encode(Encoding::BINARY)
      packet_type.fields.each do |field|
        val = object.send(field[:name])

        case field[:type]
        when :varint
          packet << ::Takumi::Packet::Varint.new(val).to_s
        when :string
          packet << ::Takumi::Packet::String.new(val).to_s
        when :ushort
          packet << ::Takumi::Packet::Ushort.new(val).to_s
        else
          raise ::Takumi::Packet::UnknownField, field.inspect
        end
      end
      size = ::Takumi::Packet::Varint.new(packet.size).to_s
      size + packet
    end
  end
end

require "takumi/packet/dsl"
require "takumi/packet/varint"
require "takumi/packet/string"
require "takumi/packet/ushort"
