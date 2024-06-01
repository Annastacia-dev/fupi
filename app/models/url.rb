# == Schema Information
#
# Table name: urls
#
#  id         :uuid             not null, primary key
#  original   :string
#  shortened  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Url < ApplicationRecord
  # validations
  validates :original, presence: true, uniqueness: true
  validate :valid_url

  # callbacks
  before_create :generate_shortened_url

  # constants
  URL_REGEX = /\A(http|https):\/\/[a-zA-Z0-9\-.]+\.[a-zA-Z]{2,}(\/\S*)?\z/i

  def has_shortened_url?
    shortened.present?
  end

  private

  def generate_shortened_url
    short_url = SecureRandom.urlsafe_base64(6)
    if Url.where(shortened: short_url).exists?
      generate_shortened_url
    else
      self.shortened = short_url
    end
  end

  def valid_url
    unless original =~ URL_REGEX
      errors.add(:original, 'Invalid URL')
    end
  end
end
