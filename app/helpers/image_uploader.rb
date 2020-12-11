require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.validate do
    #Validate file format
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]

    #Limit file size to 10MB
    validate_max_size 10*1024*1024
  end

  #Crop images and save to storage to avoid reprocessing each time the page loads
  plugin :derivation_endpoint, secret_key: 'y0yo22GjcGCMMDwHwemhy0XWh4fVazdt', prefix: "derivations", upload: true

  derivation :cropped do |file, width, height|
    ImageProcessing::MiniMagick
      .source(file)
      .resize_to_limit!(width.to_i, height.to_i)
  end
end