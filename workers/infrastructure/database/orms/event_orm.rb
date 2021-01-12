# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object-Relational Mapper for Events
    class EventOrm < Sequel::Model(:events)
      one_to_many :sessions,
                  # It would be better to pass class & key explicitly,
                  # because we may change the class name & key name, which are not in line with the convention.
                  class: :'IndieLand::Database::SessionOrm',
                  key: :event_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(event)
        first(event_uid: event[:event_uid]) || create(event)
      end
    end
  end
end
