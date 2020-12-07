# frozen_string_literal: true

module IndieLand
  module Response
    # OpenStruct for deserializing json with hypermedia
    # :reek:Attribute
    class OpenStructWithLinks < OpenStruct
      attr_accessor :links
    end
  end
end
