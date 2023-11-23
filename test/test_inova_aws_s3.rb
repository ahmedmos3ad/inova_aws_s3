# frozen_string_literal: true

require "test_helper"
require 'minitest/autorun'

require 'inova_aws_s3'
require 'aws/s3_service'
require_relative '../lib/inova_aws_s3/test_config.rb'

class TestInovaAwsS3 < Minitest::Test

  def setup
    # Initialize the configuration for each test
    InovaAwsS3.configuration = InovaAwsS3::Configuration.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::InovaAwsS3::VERSION
  end

  def test_onepart_upload
    # Mock the necessary objects and test onepart upload functionality
    s3_service = Aws::S3Service.new
    # Set up mock file and other necessary data
    result = s3_service.onepart_upload(file_name: 'Gemfile.lock', tempfile: 'Gemfile.lock')
    # Assert the result based on your expectations
    assert_match URI::DEFAULT_PARSER.make_regexp, result
  end
end
