# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object Relational Mapper for Session Entities
    class SessionOrm < Sequel::Model(:sessions)
      many_to_one :event,
                  # It would be better to pass class & key explicitly,
                  # because we may change the class name & key name, which are not in line with the convention.
                  class: :'IndieLand::Database::EventOrm',
                  key: :event_id

      plugin :timestamps, update_on_create: true
    end
  end
end
