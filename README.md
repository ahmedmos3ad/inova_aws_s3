# InovaAwsS3
InovaAwsS3 is a Ruby gem designed to simplify interactions with Amazon S3, providing seamless integration for uploading, managing, and retrieving files from your S3 buckets. Whether you're building a web application, handling backups, or managing assets, InovaAwsS3 offers a clean and efficient interface to harness the power of Amazon S3 within your Ruby projects.
## Installation

To use this gem in your project, add it to your application's Gemfile:

```ruby
gem 'inova_aws_s3', '~> 0.1.0'
```

Alternatively, you can install the gem directly using:

```bash
gem install inova_aws_s3 -v '~> 0.1.0'
```
## Requirments

- Ruby >= 3.0.0
- Rails >= 6.1.3

## Usage

```bash
rails generate inova_aws_s3:install
```

This will create a configuration file at config/initializers/inova_aws_s3.rb. Open the file and set your AWS credentials:

```ruby
InovaAwsS3.configure do |config|
  config.acl = 'public-read'
  config.bucket_name = 'your_bucket_name'
  config.region = 'your_region'
  config.access_key = 'your_access_key'
  config.secret_key = 'your_secret_key'
  config.folder_name = 'your_folder_name'
end
```

Replace the placeholder values with your actual AWS credentials.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ahmedmos3ad/inova_aws_s3/pulls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ahmedmos3ad/inova_aws_s3/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InovaAwsS3 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ahmedmos3ad/inova_aws_s3/blob/master/CODE_OF_CONDUCT.md).
