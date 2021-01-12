# frozen_string_literal: true

require_relative 'sessions'
require_relative 'events'
require_relative 'tickets'

module IndieLand
  module Repository
    # Finds the right repository for an entity object or class
    class For
      ENTITY_REPOSITORY = {
        Entity::Event => Events,
        Entity::Session => Sessions,
        Entity::Ticket => Tickets
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end
    end
  end
end
