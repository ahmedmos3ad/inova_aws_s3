# test_config.rb

module InovaAwsS3
  class Configuration
    require "dotenv"
    Dotenv.load(".env")
    attr_accessor :acl, :bucket_name, :region, :access_key, :secret_key, :folder_name

    def initialize
      # Set test-specific configuration values here
      @acl = ENV["TEST_ACL"]
      @bucket_name = ENV["TEST_BUCKET"]
      @region = ENV["TEST_REGION"]
      @access_key = ENV["TEST_ACCESS_KEY"]
      @secret_key = ENV["TEST_SECRET_KEY"]
      @folder_name = ENV["TEST_FOLDER"]
    end
  end
end
