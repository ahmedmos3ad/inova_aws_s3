# frozen_string_literal: true

require_relative "inova_aws_s3/version"
require_relative "inova_aws_s3/configuration"
require_relative "inova_aws_s3/service"

module InovaAwsS3
  class Error < StandardError; end
  # Your code goes here...

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
