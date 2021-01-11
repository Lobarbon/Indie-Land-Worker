# frozen_string_literal: true

module IndieLand
  module MinistryOfCulture
    # Data Mapper
    class TicketsMapper
      def initialize(gateway_class = MinistryOfCulture::TicketApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find_tickets
        build_entity
      end

      private

      def build_entity
        @gateway.data.map do |ticket|
          TicketMapper.new(ticket).build_entity
        end
      end

      # Extracts entity specific elements from data structure
      class TicketMapper
        def initialize(ticket)
          @ticket = ticket
        end

        def build_entity
          IndieLand::Entity::Ticket.new(
            ticket_id: nil,
            ticket_title: ticket_title,
            ticket_url: ticket_url
          )
        end

        private

        def ticket_title
          @ticket['title']
        end

        def ticket_url
          @ticket['url']
        end
      end
    end
  end
end
