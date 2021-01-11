# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for an Comment
    class Comment < Dry::Struct
      include Dry.Types

      attribute :event_id, Strict::Integer
      attribute :comment, Strict::String

      def to_hash
        { event_id: event_id, comment: comment }
      end
    end
  end
end
