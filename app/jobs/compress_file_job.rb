class CompressFileJob < ApplicationJob
  queue_as :default

  def perform(upload_id)
    upload = Upload.find_by(id: upload_id)
    return unless upload&.file&.attached?

    case upload.file.content_type
    when 'image/jpeg', 'image/png'
      compress_image(upload)
    when 'application/pdf'
      compress_pdf(upload)
    when 'video/mp4'
      compress_mp4(upload)
    end
  end

  private

  def compress_image(upload)
    require 'mini_magick'

    downloaded = ActiveStorage::Blob.service.download(upload.file.key)
    image = MiniMagick::Image.read(downloaded)
    image.strip
    image.quality(70)

    compressed_io = StringIO.new(image.to_blob)
    upload.file.purge
    upload.file.attach(io: compressed_io, filename: upload.file.filename.to_s, content_type: upload.file.content_type)
  end

  def compress_pdf(upload)
    input_file = Tempfile.new(['input', '.pdf'])
    output_file = Tempfile.new(['output', '.pdf'])

    input_file.binmode
    input_file.write ActiveStorage::Blob.service.download(upload.file.key)
    input_file.rewind

    output_path = output_file.path
    input_path = input_file.path

    system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=#{output_path} #{input_path}")

    upload.file.purge
    upload.file.attach(io: File.open(output_path), filename: upload.file.filename.to_s, content_type: upload.file.content_type)

    input_file.close!
    output_file.close!
  end

  def compress_mp4(upload)
    input = Tempfile.new(['input', '.mp4'])
    output = Tempfile.new(['compressed', '.mp4'])

    input.binmode
    input.write ActiveStorage::Blob.service.download(upload.file.key)
    input.rewind

    output_path = output.path
    input_path = input.path

    # Example: lower bitrate and resolution (adjust as needed)
    system("ffmpeg -i #{input_path} -vcodec libx264 -crf 28 -preset fast -acodec aac #{output_path}")

    upload.file.purge
    upload.file.attach(io: File.open(output_path), filename: upload.file.filename.to_s, content_type: upload.file.content_type)

    input.close!
    output.close!
  end

end
