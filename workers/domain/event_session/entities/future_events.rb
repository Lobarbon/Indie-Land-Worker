# frozen_string_literal: false

require 'set'

module IndieLand
  module Entity
    # Domain entity for Future EventSesions
    class FutureEvents < SimpleDelegator
      def initialize(future_events, today)
        super([future_events, today])
        @events = future_events
        @today = today
      end

      def events_on_this_date(date)
        @events
          .map { |event| event.event_on_this_date(date) }
          .delete_if(&:nil?)
      end

      def future_dates
        @events
          .reduce(Set.new) do |set, event|
            set.merge(event.future_hold_dates(@today))
          end
          .to_a
          .sort
      end
    end
  end
end
