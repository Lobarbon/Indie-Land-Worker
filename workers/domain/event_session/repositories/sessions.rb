# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Session Entities
    class Sessions
      def self.create_sessions_from_one_event(event_record, session_entities)
        # Without this line, it will cause errors if we are trying to set sessions with primary keys
        Database::SessionOrm.unrestrict_primary_key

        session_entities.map(&:to_attr_hash).each_with_index do |session, idx|
          session[:event_id] = event_record.id
          session[:session_id] = idx
          event_record.add_session session
        end
      end
    end

    # A class for building Session Entity
    class SessionEntityBuilder
      def self.rebuild_entities(session_records)
        return nil unless session_records

        session_records.map do |session_record|
          rebuild_entity session_record
        end
      end

      def self.rebuild_entity(session_record)
        Entity::Session.new(
          session_id: session_record.session_id,
          event_id: session_record.event_id,
          # The type of start_time and end_time should be DateTime and
          # the database will return a Time object of start_time and end_time.
          # Therefore, we need to convert them to DateTime object.
          start_time: Utility.time_to_datetime(session_record.start_time),
          end_time: Utility.time_to_datetime(session_record.end_time),
          address: session_record.address,
          place: session_record.place,
          ticket_price: session_record.ticket_price
        )
      end
    end
  end
end
