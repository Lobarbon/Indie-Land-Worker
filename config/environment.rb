# frozen_string_literal: true

require 'econfig'

module IndieLand
  # Setup config environment
  class MsgWorker
    # plugin :environments
    extend Econfig::Shortcut
    Econfig.env = ENV['WORKER_ENV'] || 'development'
    Econfig.root = File.expand_path('..', File.dirname(__FILE__))
  end
end
