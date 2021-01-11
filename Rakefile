# frozen_string_literal: true

require 'rake/testtask'

CODE = 'app/'
USERNAME = 'soumyaray'
IMAGE = 'ruby-http'
VERSION = '2.7.2'

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.warning = false
end

desc 'Keep rerunning tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
end

namespace :check do
  desc 'run all quality checks'
  task all: %i[cop flog reek]

  desc 'run all quality checks without auto-correct'
  task ci_all: %i[kind_cop flog reek]

  desc 'run rubocop'
  task :cop do
    sh 'rubocop -A'
  end

  desc 'run rubocop without auto-correct'
  task :kind_cop do
    sh 'rubocop'
  end

  desc 'run flog for abc metric'
  task :flog do
    sh "flog #{CODE}"
  end

  desc 'run reek for bad smell code'
  task :reek do
    sh "reek #{CODE}"
  end
end

# desc 'Build Docker image'
# task :worker do
#   require_relative './init'
#   IndieLand::MsgWorker.new.call
# end

namespace :worker do
  namespace :run do
    desc 'Run the background message worker in development mode'
    task dev: :config do
      sh 'RACK_ENV=development bundle exec shoryuken -r ./workers/msg_worker.rb -C ./workers/shoryuken_dev.yml'
    end

    desc 'Run the background message worker in testing mode'
    task test: :config do
      sh 'RACK_ENV=test bundle exec shoryuken -r ./workers/msg_worker.rb -C ./workers/shoryuken_test.yml'
    end

    desc 'Run the background message worker in production mode'
    task production: :config do
      sh 'RACK_ENV=production bundle exec shoryuken -r ./workers/msg_worker.rb -C ./workers/shoryuken.yml'
    end
  end
end

# Docker tasks
namespace :docker do
  desc 'Build Docker image'
  task :build do
    puts "\nBUILDING WORKER IMAGE"
    sh "docker build --force-rm -t #{USERNAME}/#{IMAGE}:#{VERSION} ."
  end

  desc 'Run the local Docker container as a worker'
  task :run do
    env = ENV['WORKER_ENV'] || 'development'

    puts "\nRUNNING WORKER WITH LOCAL CONTEXT"
    puts " Running in #{env} mode"

    sh 'docker run -e WORKER_ENV -v $(pwd)/config:/worker/config --rm -it ' \
       "#{USERNAME}/#{IMAGE}:#{VERSION}"
  end

  desc 'Remove exited containers'
  task :rm do
    sh 'docker rm -v $(docker ps -a -q -f status=exited)'
  end

  desc 'List all containers, running and exited'
  task :ps do
    sh 'docker ps -a'
  end

  # desc 'Push Docker image to Docker Hub'
  # task :push do
  #   puts "\nPUSHING IMAGE TO DOCKER HUB"
  #   sh "docker push #{USERNAME}/#{IMAGE}:#{VERSION}"
  # end
end

# Heroku container registry tasks
namespace :heroku do
  desc 'Build and Push Docker image to Heroku Container Registry'
  task :push do
    puts "\nBUILDING + PUSHING IMAGE TO HEROKU"
    sh 'heroku container:push worker'
  end

  desc 'Run worker on Heroku'
  task :run do
    puts "\nRUNNING CONTAINER ON HEROKU"
    sh 'heroku run rake worker'
  end
end

namespace :queues do
  task :config do
    require 'aws-sdk-sqs'
    require_relative 'config/environment' # load config info
    @api = IndieLand::App

    @sqs = Aws::SQS::Client.new(
      access_key_id: @api.config.AWS_ACCESS_KEY_ID,
      secret_access_key: @api.config.AWS_SECRET_ACCESS_KEY,
      region: @api.config.AWS_REGION
    )
  end

  desc 'Create SQS queue for worker'
  task create: :config do
    puts "Environment: #{@api.environment}"
    @sqs.create_queue(queue_name: @api.config.MSG_QUEUE)

    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url
    puts 'Queue created:'
    puts "  Name: #{@api.config.MSG_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error creating queue: #{e}"
  end

  desc 'Report status of queue for worker'
  task status: :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url

    puts "Environment: #{@api.environment}"
    puts 'Queue info:'
    puts "  Name: #{@api.config.MSG_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error finding queue: #{e}"
  end

  desc 'Purge messages in SQS queue for worker'
  task purge: :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url
    @sqs.purge_queue(queue_url: q_url)
    puts "Queue #{queue_name} purged"
  rescue StandardError => e
    puts "Error purging queue: #{e}"
  end
end

desc 'Run application console (irb)'
task :console do
  sh 'irb -r ./init'
end
# rubocop:enable Metrics/BlockLength
