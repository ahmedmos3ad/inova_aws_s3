module InovaAwsS3
  class Configuration
    attr_accessor :acl, :bucket_name, :region, :access_key, :secret_key, :folder_name

    def initialize
      # Set default values or raise an error if required values are not set
      @acl = 'public-read'
      @bucket_name = nil
      @region = nil
      @access_key = nil
      @secret_key = nil
      @folder_name = nil
    end
  end
end
