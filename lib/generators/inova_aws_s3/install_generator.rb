require "rails/generators"

module InovaAwsS3
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer_file
        copy_file "inova_aws_s3_initializer.rb", "config/initializers/inova_aws_s3.rb"
      end
    end
  end
end
