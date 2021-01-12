# frozen_string_literal: true

require 'ostruct'

%w[config workers]
  .reduce([]) { |files, folder| files << Dir.glob("#{folder}/**/*.rb") }
  .flatten
  .sort
  .each { |file| require_relative file }
