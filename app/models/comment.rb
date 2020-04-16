class Comment < ApplicationRecord
  belongs_to :article
  # validates :author_name, presence: true
end
