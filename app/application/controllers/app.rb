# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    logger = AppLogger.instance.get

    plugin :halt
    plugin :flash
    plugin :all_verbs # allows DELETE and other HTTP verbs beyond GET/POST
    use Rack::MethodOverride

    route do |routing|
      # set response content type to json
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "IndieLand API v1 at /api/v1 in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code

        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'events' do
          routing.get do
            result = Service::ListEvents.new.call(logger: logger)

            if result.failure?
              failed = Representer::HttpResponse.new(result.failure)
              routing.halt failed.http_status_code, failed.to_json
            end

            http_response = Representer::HttpResponse.new(result.value!)
            response.status = http_response.http_status_code

            Representer::RangeEvents.new(result.value!.message).to_json
          end
        end
      end
    end
  end
end
