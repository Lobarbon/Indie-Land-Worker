# frozen_string_literal: true

module IndieLand
  module Repository
    # User repository class
    class Users
      def self.manager
        IndieLand::Entity::UserManager.instance
      end
    end
  end
end
