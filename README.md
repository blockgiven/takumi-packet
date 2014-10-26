# Takumi::Packet

minecraft protocol packet encode/decode utility.

Details: [Protocol - MinecraftCoalition](http://wiki.vg/Protocol)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'takumi-packet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install takumi-packet

## Usage

### Gems use takumi-packet

- [blockgiven/takumi-server_list_ping](https://github.com/blockgiven/takumi-server_list_ping)

### Define packet

    require 'ostruct'
    require 'takumi/packet'

    class Handshake < OpenStruct
      include ::Takumi::Packet::Dsl

      field :packet_id,      :varint
      field :version,        :varint
      field :server_address, :string
      field :port,           :ushort
      field :next_state,     :varint
    end

### Encode packet
    p Handshake.new({
      packet_id:      0,
      version:        4,
      server_address: 'localhost',
      port:           25565,
      next_state:     1
    }).to_s

    # => "\x0F\x00\x04\tlocalhostc\xDD\x01"

### Decode packet

    packet = "\x0F\x00\x04\tlocalhostc\xDD\x01"

    p Handshake.decode(packet)
    # => #<Handshake packet_id=0, version=4, server_address="localhost", port=[25565], next_state=1>

## Contributing

1. Fork it ( https://github.com/blockgiven/takumi-packet/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
