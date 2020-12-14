ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "shrine/storage/memory"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...


  #Log user in
  def log_in(username, password)
    post login_url, params: {username: username, password: password}
  end

  #Generate test image data
  module TestImage
    module_function

    def image_data
      attacher = Shrine::Attacher.new
      attacher.set(uploaded_image)
      attacher.column_data # or attacher.data in case of postgres jsonb column
    end

    def uploaded_image
      #Upload test images to memory instead of permanent storage
      Shrine.storages = {
        cache: Shrine::Storage::Memory.new,
        store: Shrine::Storage::Memory.new,
      }

      #Some public domain picture of a car i got from unsplash
      file = File.open("test/files/image.jpg", binmode: true)

      # for performance we skip metadata extraction and assign test metadata
      uploaded_file = Shrine.upload(file, :store, metadata: false)
      uploaded_file.metadata.merge!(
        "size"      => File.size(file.path),
        "mime_type" => "image/jpeg",
        "filename"  => "test.jpg",
        )

      uploaded_file
    end
  end
end
