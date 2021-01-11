# frozen_string_literal: true

require('set')

module IndieLand
  module Repository
    # Repository for Events
    class Events
      def self.future_events
        today = DateTime.now.to_date
        event_entities = future_event_ids(today).map { |event_id| find_id(event_id) }

        FutureEventsEntityBuilder.rebuild_entity(event_entities, today)
      end

      def self.future_event_ids(today)
        # the set will contain events' event_id,
        # those events have at least one future session hold

        # The Query looks like:
        # ---------------------------------------------
        # SELECT DISTINCT `id` FROM `events`
        # INNER JOIN `sessions`
        # ON (`sessions`.`event_id` = `events`.`id`)
        # WHERE (`start_time` > '2020-11-14')
        # ---------------------------------------------

        Database::EventOrm
          .join(:sessions, [%i[event_id id]])
          .where { start_time > today }
          .distinct
          .select(:id)
          .all
          .map(&:id)
      end

      def self.query_events(query)
        EventEntityBuilder.rebuild_entities search_name(query)
      end

      def self.search_name(query)
        Database::EventOrm.where(Sequel.like(:event_name, "%#{query}%")).all
      end

      def self.find_all
        EventEntityBuilder.rebuild_entities Database::EventOrm.all
      end

      def self.find_id(event_id)
        EventEntityBuilder.rebuild_entity Database::EventOrm.first(id: event_id)
      end

      def self.like_event(event_id)
        puts event_id
        event_record = Database::EventOrm.first(id: event_id)
        event_record.update(like_num: event_record.like_num + 1)
      end

      def self.create_many(entities)
        raise TypeError('Please pass an array of entities.') unless entities.is_a? Array

        entities.map do |entity|
          create_one(entity)
        end
      end

      def self.create_one(entity)
        raise TypeError('Please pass an entity or you could use create_many.') if entity.is_a? Array

        event_record = Database::EventOrm.find_or_create(entity.to_attr_hash)
        # if the sessions have been saved into databse, just return
        return EventEntityBuilder.rebuild_entity(event_record) unless event_record.sessions.empty?

        # if the sessions have not been saved,
        # save it and find it again(Sessions will automatically associate with Event)
        Sessions.create_sessions_from_one_event(event_record, entity.sessions)
        find_id(event_record.id)
      end
    end

    # A class for building EventSession Entity
    class FutureEventsEntityBuilder
      def self.rebuild_entity(event_entities, today)
        Entity::FutureEvents.new(event_entities, today)
      end
    end

    # A class for building Event Entity
    class EventEntityBuilder
      def self.rebuild_entities(event_records)
        return nil unless event_records

        event_records.map do |event_record|
          rebuild_entity event_record
        end
      end

      # rubocop:disable Metrics/MethodLength
      def self.rebuild_entity(event_record)
        Entity::Event.new(
          event_id: event_record.id,
          event_uid: event_record.event_uid,
          event_name: event_record.event_name,
          event_website: event_record.event_website,
          event_ticket_website: event_record.event_ticket_website,
          description: event_record.description,
          sale_website: event_record.sale_website,
          source: event_record.source,
          like_num: event_record.like_num,
          sessions: SessionEntityBuilder.rebuild_entities(event_record.sessions)
        )
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
