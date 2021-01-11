# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for ticket
    class Ticket < Dry::Struct
      include Dry.Types

      attribute :ticket_id, Strict::Integer.optional
      attribute :ticket_title, Strict::String
      attribute :ticket_url, Strict::String

      def to_attr_hash
        to_hash.reject { |key| %i[ticket_id].include? key }
      end
    end
  end
end
