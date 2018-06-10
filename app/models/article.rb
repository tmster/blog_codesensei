class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { minimum: 5 }
  validate :title_changes
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes

  belongs_to :author, class_name: 'User'
  scope :top_commented, -> { order(comments_count: :desc).limit(1) }
  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  private

  def title_changes
    if title_changed? && persisted? && created_at < 7.days.ago
      errors.add(:title, "cannot be changed")
    end
  end

  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
