# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents Like message
module IndieLand
  module Representer
    # Represent a like message
    class QueueMsg < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :event_id
      property :comment
      property :request_id

      private

      def event_id
        represented.event_id
      end

      def comment
        represented.comment
      end

      def request_id
        represented.request_id
      end
    end
  end
end
