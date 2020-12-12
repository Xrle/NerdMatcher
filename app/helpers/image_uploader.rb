require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.validate do
    #Validate file format
    validate_mime_type %w[image/jpeg image/png image/webp]

    #Limit file size to 10MB
    validate_max_size 10*1024*1024
  end

  #Resize images to required dimensions
  plugin :derivation_endpoint, secret_key: Rails.application.credentials[:derivation_key], prefix: "derivations"

  derivation :resized do |file, width, height|
    ImageProcessing::MiniMagick.source(file).resize_to_fill!(width.to_i, height.to_i)
  end
end