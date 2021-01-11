# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for an Comment
    class Comments < Dry::Struct
      include Dry.Types

      attribute :event_id, Strict::Integer
      attribute :comments, Strict::Array.of(Comment)
    end
  end
end
