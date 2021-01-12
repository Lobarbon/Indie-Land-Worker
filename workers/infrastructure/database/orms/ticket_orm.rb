# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object Relational Mapper for Ticket Entities
    class TicketOrm < Sequel::Model(:tickets)
      # one_to_one :event,
      #             # It would be better to pass class & key explicitly,
      #             # because we may change the class name & key name, which are not in line with the convention.
      #             class: :'IndieLand::Database::EventOrm',
      #             key: :event_name

      plugin :timestamps, update_on_create: true

      def self.find_or_create(ticket)
        first(ticket_title: ticket[:ticket_title]) || create(ticket)
      end
    end
  end
end
