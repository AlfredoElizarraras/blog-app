require 'rails_helper'

RSpec.describe Article, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:author) { Author.new(username: 'Author test', email: "author@mail.com")}
  let(:article) { Article.new(title: 'Rails test post!') }
  let(:comment) { Comment.new(body: 'Test comment')}
  
  before do 
    author.save
    article.author_id = author.id
    20.times do |indx|
      article.text = "first" if article.text.nil?
      article.text += indx.to_s
    end
    article.tag_list = "test_tag1, test_tag2"
    article.save
    comment.author_name = author.username
    comment.author_id = author.id
    comment.article_id = article.id
    comment.save

  end
  it 'title should be present.' do
    expect(article).to be_valid
  end

  it 'if title is not present article is not valid.' do
    article.title = nil
    expect(article).to_not be_valid
  end

  it 'title should be at least 5 characters long.' do
    expect(article).to be_valid
  end

  it 'title with less than 5 characters is not valid.' do
    article.title = 'abcd'
    expect(article).to_not be_valid
  end

  it 'text should be present' do
    expect(article).to be_valid
  end

  it 'if text is not present, article is not valid.' do
    article.text = nil
    expect(article).to_not be_valid
  end

  it 'text with less than 20 characters is not valid.' do
    article.text = 'abcd'
    expect(article).to_not be_valid
  end

  it 'text with more than 1000 characters is not valid.' do
    980.times do |indx|
      article.text += indx.to_s
    end
    expect(article).to_not be_valid
  end

  context 'When articles get destroyed.' do
    before do
      article.destroy
    end

    it 'destroy the comments related with the article.' do
      comment = article.comments.first
      expect(comment).to be(nil)
    end

    it 'destroy the tagging related with the article' do
      tagging = article.taggings.first
      expect(tagging).to be_nil
    end
  end
end
