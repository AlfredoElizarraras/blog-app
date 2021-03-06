class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :article
  validates :author_name, presence: true
  validates :body, presence: true
end
