class Upload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :title, presence: true
  validate :file_presence_required
  validate :file_size_within_limit

  before_save :extract_file_metadata
  before_create :generate_url
  after_commit :may_compress_file, on: :create

  COMPRESSIBLE_TYPES = %w[
    image/png
    image/jpeg
    application/pdf
    image/gif
    video/mp4
  ]

  MAX_FILE_SIZE = 1.gigabyte

  private

  def file_presence_required
    if new_record? && !file.attached?
      errors.add(:file, "must be attached")
    end
  end

  def file_size_within_limit
    return unless file.attached?
    if file.byte_size > MAX_FILE_SIZE
      errors.add(:file, "must be less than 1 GB")
    end
  end

  def extract_file_metadata
    return unless file.attached?

    self.file_type = file.content_type
    self.file_size = file.byte_size
  end

  def generate_url
    self.url = SecureRandom.alphanumeric(8)
  end

  def may_compress_file
    return unless file.attached?
    return unless COMPRESSIBLE_TYPES.include?(file.content_type)
    return if file.byte_size < 1.megabyte
    return if file.content_type == 'image/gif' # skipping gif

    CompressFileJob.perform_later(id)
  end
end
