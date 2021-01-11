# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # User entity
    class User < Dry::Struct
      include Dry.Types

      attribute :uid, Strict::String
      attribute :login_number, Strict::Integer

      def to_attr_hash
        to_hash
      end
    end
  end
end
