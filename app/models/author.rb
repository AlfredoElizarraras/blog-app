class Author < ApplicationRecord
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: 'should match confirmation', if: :password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
end
