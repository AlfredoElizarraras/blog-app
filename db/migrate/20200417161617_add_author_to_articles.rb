class AddAuthorToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :author, null: false, foreign_key: true
  end
end
