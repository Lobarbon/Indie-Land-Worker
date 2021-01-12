# frozen_string_literal: true

require 'yaml'
require 'econfig'
require 'delegate'

module IndieLand
  # Setup config environment
  class MsgWorker
    extend Econfig::Shortcut
    Econfig.env = ENV['WORKER_ENV'] || 'development'
    Econfig.root = File.expand_path('..', File.dirname(__FILE__))

    
    ENV['DATABASE_URL'] = ENV['DATABASE_URL'] || "sqlite://#{config.DB_FILENAME}"
    # puts ENV['DATABASE_URL']
    
    require 'sequel'

    @db = Sequel.connect(ENV['DATABASE_URL'])
    def self.db
      @db
    end
  end
end
