class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many_attached :images, dependent: :destroy
  validate :correct_image_mime_type
  validates :text, presence: true, length: { minimum: 20, maximum: 1000 }

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  private

  def correct_image_mime_type
    return unless images.attached?

    images.each do |image|
      unless image.content_type.match(/([a-zA-Z0-9\s_\\.\-\(\):])+(.jpg|.jpeg|.png)$/)
        errors.add(:images, 'Must be a jpg, jpeg or a png file')
      end
    end
  end
end
