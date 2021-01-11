# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for an Event
    class Like < Dry::Struct
      include Dry.Types

      attribute :event_id, Strict::Integer
      attribute :like_num, Strict::Integer

      def to_hash
        { event_id: event_id, like_num: like_num }
      end
    end
  end
end
