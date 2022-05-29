# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 100 } }
  validates :user_id, { presence: true }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :notifications, dependent: :destroy
  def user
    User.find_by(id: user_id)
  end

  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_post_tag
    end
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id,
                               user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end
end
