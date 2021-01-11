# frozen_string_literal: true

require('set')

module IndieLand
  module Repository
    # Repository for Events
    class Tickets
      def self.find_all
        puts TicketEntityBuilder.rebuild_entities Database::TicketOrm.all
      end

      def self.find_ticket(ticket_title)
        begin
          ticket = TicketEntityBuilder.rebuild_entity Database::TicketOrm.first(ticket_title: ticket_title)
        rescue StandardError
          ticket = { ticket_url: '' }
        end
        ticket
      end

      def self.create_many(entities)
        raise TypeError('Please pass an array of entities.') unless entities.is_a? Array

        entities.map do |entity|
          create_one(entity)
        end
      end

      def self.create_one(entity)
        raise TypeError('Please pass an entity or you could use create_many.') if entity.is_a? Array

        Database::TicketOrm.find_or_create(entity.to_attr_hash)
      end
    end

    # A class for building Event Entity
    class TicketEntityBuilder
      def self.rebuild_entities(ticket_records)
        return nil unless ticket_records

        ticket_records.map do |ticket_record|
          rebuild_entity ticket_record
        end
      end

      def self.rebuild_entity(ticket_record)
        Entity::Ticket.new(
          ticket_id: ticket_record.id,
          ticket_title: ticket_record.ticket_title,
          ticket_url: ticket_record.ticket_url
        )
      end
    end
  end
end
