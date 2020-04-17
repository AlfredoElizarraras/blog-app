class Comment < ApplicationRecord
  belongs_to :author, :article
  validates :author_name, presence: true
  validates :body, presence: true
end
