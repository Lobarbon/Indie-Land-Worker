# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object-Relational Mapper for Events
    class CommentOrm < Sequel::Model(:comments)
      plugin :timestamps, update_on_create: true
    end
  end
end
