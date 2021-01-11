# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for Session
    class Session < Dry::Struct
      include Dry.Types

      attribute :session_id, Strict::Integer.optional
      attribute :event_id, Strict::Integer.optional
      attribute :start_time,  Strict::DateTime
      attribute :end_time,    Strict::DateTime
      attribute :address,     Strict::String.optional
      attribute :place,       Strict::String.optional
      attribute :ticket_price, Strict::String.optional

      def to_attr_hash
        to_hash
      end

      def to_brief_hash
        { session_id: session_id }
      end

      def date
        # return the date of the session hold
        start_time.to_date
      end

      def hold_on_this_date?(date)
        date == start_time.to_date
      end
    end
  end
end
