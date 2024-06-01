# == Schema Information
#
# Table name: urls
#
#  id           :uuid             not null, primary key
#  custom_alias :string
#  expiry_date  :datetime
#  original     :string
#  shortened    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Url < ApplicationRecord
  # validations
  validates :original, presence: true, uniqueness: true
  validates :custom_alias, uniqueness: true, length: { maximum: 10 }, format: { with: /\A[\w\-]+\z/, message: "only allows letters, numbers, hyphens, and underscores, and no spaces" }, allow_blank: true
  validate :valid_url

  # callbacks
  before_save :downcase_custom_alias
  before_create :generate_shortened_url, if: :custom_alias_blank?
  before_create :set_expiry_date

  # constants
  URL_REGEX = /\A(http|https):\/\/[a-zA-Z0-9\-.]+\.[a-zA-Z]{2,}(\/\S*)?\z/i

  def has_shortened_url?
    shortened.present? || custom_alias.present?
  end

  def short_url
    shortened || custom_alias
  end

  private

  def custom_alias_blank?
    custom_alias.blank?
  end

  def generate_shortened_url
    length = rand(6..8)
    short_url = SecureRandom.urlsafe_base64(length)
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

  def downcase_custom_alias
    self.custom_alias = custom_alias.downcase if custom_alias.present?
  end

  def set_expiry_date
    self.expiry_date = Time.current + 1.month
  end
end
