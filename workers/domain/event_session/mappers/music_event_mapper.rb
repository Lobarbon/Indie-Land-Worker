# frozen_string_literal: true

require 'date'

module IndieLand
  module MinistryOfCulture
    # Data Mapper
    class MusicEventsMapper
      def initialize(gateway_class = MinistryOfCulture::MusicApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find_events
        build_entity
      end

      private

      def build_entity
        @gateway.data.map do |event|
          EventMapper.new(event).build_entity
        end
      end

      # Extracts entity specific elements from data structure
      class EventMapper
        def initialize(event)
          @event = event
        end

        # rubocop:disable Metrics/MethodLength
        def build_entity
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: event_uid,
            event_name: event_name,
            event_website: event_website,
            event_ticket_website: event_ticket_website,
            description: description,
            sale_website: sale_website,
            source: source,
            sessions: sessions,
            like_num: 0
          )
        end
        # rubocop:enable Metrics/MethodLength

        private

        def event_uid
          @event['UID']
        end

        def event_name
          @event['title']
        end

        def event_website
          @event['sourceWebPromote']
        end

        def event_ticket_website
          Repository::Tickets.find_ticket(event_name)[:ticket_url]
        end

        def ticket_website
          @event['webSales']
        end

        def description
          @event['descriptionFilterHtml']
        end

        def sale_website
          @event['webSales']
        end

        def source
          @event['sourceWebName']
        end

        def sessions
          @event['showInfo'].map do |session|
            SessionMapper.new(session).build_entity
          end
        end
      end

      # SessionMapper will map sessions of an event
      class SessionMapper
        def initialize(session)
          @session = session
        end

        def build_entity
          IndieLand::Entity::Session.new(
            session_id: nil,
            event_id: nil,
            start_time: start_time,
            end_time: end_time,
            address: address,
            place: place,
            ticket_price: ticket_price
          )
        end

        def start_time
          DateTime.parse(@session['time'])
        end

        def end_time
          DateTime.parse(@session['endTime'])
        end

        def address
          @session['location']
        end

        def place
          @session['locationName']
        end

        def ticket_price
          @session['price']
        end
      end
    end
  end
end
