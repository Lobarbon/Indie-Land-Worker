# frozen_string_literal: true

require_relative '../helpers/spec_helper'
require_relative '../helpers/vcr_helper'
require_relative '../helpers/database_helper'
require 'rack/test'

def app
  IndieLand::App
end

# rubocop:disable Metrics/BlockLength
describe 'Test API routes' do
  include Rack::Test::Methods

  VcrHelper.setup
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.insert
    DatabaseHelper.wipe_database
  end

  after do
    VcrHelper.eject
  end

  describe 'Root route' do
    it 'should successfully return root information' do
      get '/'
      _(last_response.status).must_equal 200

      body = JSON.parse(last_response.body)
      _(body['status']).must_equal 'ok'
      _(body['message']).must_include 'api/v1'
    end
  end

  describe 'Get events' do
    it 'should successfully return events' do
      logger = IndieLand::AppLogger.instance.get
      IndieLand::Service::ListEvents.new.call(logger: logger)

      get '/api/v1/events'
      _(last_response.status).must_equal 200

      response = JSON.parse(last_response.body)
      range_events = response['range_events']
      _(range_events.count).wont_equal 0
    end
  end

  describe 'Get event' do
    it 'should successfully return event info' do
      logger = IndieLand::AppLogger.instance.get
      IndieLand::Service::ListEvents.new.call(logger: logger)

      get '/api/v1/events/'
      _(last_response.status).must_equal 200

      # response = JSON.parse(last_response.body)
      # range_events = response["range_events"]
      # _(range_events.count).wont_equal 0
    end
  end
end
# rubocop:enable Metrics/BlockLength