InovaAwsS3.configure do |config|
  # Set your configuration options here
  config.acl = "public-read"
  config.bucket_name = "your_bucket_name"
  config.region = "your_region"
  config.access_key = "your_access_key"
  config.secret_key = "your_secret_key"
  config.folder_name = "your_folder_name"
end
