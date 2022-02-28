# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 100 } }
  validates :user_id, { presence: true }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  def user
    User.find_by(id: user_id)
  end

  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      post_tags.delete PostTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)
      post_tags << new_post_tag
    end
  end
end
