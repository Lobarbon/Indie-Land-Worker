# frozen_string_literal: true

require 'date'

module IndieLand
  # Utility functions
  module Utility
    # Convert Time object to DateTime
    def self.time_to_datetime(time_obj)
      time_str = time_obj.strftime('%Y/%m/%d %H:%M:%S')
      DateTime.parse(time_str)
    end
  end
end
