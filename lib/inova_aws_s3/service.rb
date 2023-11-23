module InovaAwsS3
  class Service
    require "aws-sdk-s3"
    PART_SIZE = 1024 * 1024 * 10

    def initialize(acl: InovaAwsS3.configuration.acl)
      @acl = acl
      @bucket_name = InovaAwsS3.configuration.bucket_name
      @region = InovaAwsS3.configuration.region
      @access_key = InovaAwsS3.configuration.access_key
      @secret_key = InovaAwsS3.configuration.secret_key
      @folder_name = InovaAwsS3.configuration.folder_name
      set_s3_client
      set_s3_resource
    end

    def set_s3_client
      @s3_client = Aws::S3::Client.new(region: @region, access_key_id: @access_key, secret_access_key: @secret_key)
    end

    def set_s3_resource
      @s3_resource = Aws::S3::Resource.new(region: @region, access_key_id: @access_key, secret_access_key: @secret_key)
    end

    def multipart_upload(filename: nil, file: nil, acl: "public-read")
      logger ||= Logger.new("#{Rails.root}/log/uploads.log")
      key = @folder_name + filename
      resp = @s3_client.create_multipart_upload({
        bucket: @bucket_name,
        key: key, acl: acl
      })
      current_part = 1
      parts = []
      file = File.open(file, "rb")
      until file.eof?
        logger.info("#{key} Part #{current_part}")
        part = file.read(PART_SIZE)
        resp_upload = @s3_client.upload_part({
          body: part,
          bucket: @bucket_name,
          key: key,
          part_number: current_part,
          upload_id: resp.upload_id
        })

        parts << {etag: resp_upload.etag, part_number: current_part}
        current_part += 1
      end
      @s3_client.complete_multipart_upload({bucket: @bucket_name, # required
                                            key: key, # required
                                            multipart_upload: {
                                              parts: parts
                                            },
                                            upload_id: resp.upload_id})
      file.close
      set_object(key).public_url
    end

    def onepart_upload(file_name: nil, tempfile: nil)
      file_name = "#{SecureRandom.urlsafe_base64}_#{Time.now.strftime("%s")}_#{File.extname(file_name)}".gsub(/\s+/, "")
      key = @folder_name + file_name
      obj = set_object(key)
      obj.upload_file(tempfile, {acl: @acl})
      obj.public_url
    end

    def set_object(key)
      @s3_resource.bucket(@bucket_name).object(key)
    end

    def change_acl(url: nil, new_acl: "authenticated-read")
      return if url.nil?
      key = get_key_from_url(url)
      @s3_client.put_object_acl({acl: new_acl, bucket: @bucket_name, key: key})
    rescue
      puts "error in #{url}"
    end

    def get_key_from_url(url)
      # uri = URI.parse(url)
      # File.basename(uri.path)
      arr = url.split("/")
      arr[3..]&.join("/")
    end

    def valid_s3_url?(url)
      arr = url.split("/")
      host_name = "#{@bucket_name}.s3.#{@region}.amazonaws.com"
      arr[2] == host_name
    end

    def get_key(filename)
      @folder_name + filename
    end

    def generate_get_presigned(url)
      key = get_key_from_url(url)
      object = @s3_resource.bucket(@bucket_name).object(key)
      object.presigned_url(:get, expires_in: 10800) # 3 hours
    end

    def get_presigned_url(file_name)
      object = @s3_resource.bucket(@bucket_name).object(@folder_name.to_s + file_name)
      presigned_url = object.presigned_url(:put, {acl: "public-read"}) # , expires: 10*60)
      {presigned_url: presigned_url, file_url: object.public_url}
    end

    def delete_file(url)
      key = get_key_from_url(url)
      return if key.blank?
      @s3_client.delete_object({bucket: @bucket_name, key: key})
    end
  end
end
