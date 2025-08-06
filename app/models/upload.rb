class Upload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :title, presence: true

  before_save :extract_file_metadata
  before_create :generate_url

  private

  def extract_file_metadata
    return unless file.attached?

    self.file_type = file.content_type
    self.file_size = file.byte_size
  end

  def generate_url
    self.url = SecureRandom.alphanumeric(8)
  end
end
