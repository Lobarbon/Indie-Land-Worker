# frozen_string_literal: true

require 'date'
require 'singleton'
require 'securerandom'

module IndieLand
  module Entity
    # This class will mantain an user map
    # TODO: we should delete users to avoid memory leak
    class UserManager
      include Singleton

      attr_reader :user_map

      def initialize
        @user_map = {}
      end

      def create_user
        uid = SecureRandom.uuid
        user_map[uid] = User.new(uid: uid, login_number: 0)

        uid
      end

      def user_exist?(uid)
        user_map.key?(uid)
      end

      def increment_login_number(uid)
        user = user_map[uid]
        user_map[uid] = User.new(
          uid: uid,
          login_number: user.login_number + 1
        )
      end

      def login_number(uid)
        user_map[uid].login_number
      end
    end
  end
end
