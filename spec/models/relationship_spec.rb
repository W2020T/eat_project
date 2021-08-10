# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '#create' do
    before do
      @relationships = FactoryBot.build(:relationship)
    end

    it 'follower_idがnilの場合は保存できない' do
      @relationships.follower_id = nil
      @relationships.valid?
      expect(@relationship.errors.full_messages).to include('を入力してください')
    end

    it 'followed_idがnilの場合は保存できない' do
      @relationships.followed_id = nil
      @relationships.valid?
      expect(@relationships.errors.full_messages).to include('Followedを入力してください')
    end
  end

  context '一意性の検証' do
    before do
      @relationships = FactoryBot.build(:relationship)
      user1 = FactoryBot.build(:relationship)
    end
    it 'follower_idとfollowed_idの組み合わせは一意でなければ保存できない' do
      @relationships2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id)
      @relationships2.valid?
      expect(@relation2.errors.full_messages).to include('はすでに存在します')
    end

    it 'follower_idが同じでもfollowed_idが違うなら保存できる' do
      @relationships2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id)
      expect(@relationship2).to be_valid
    end

    it 'follower_idが違うならfollowed_idが同じでも保存できる' do
      relationships2 = FactoryBot.build(:relationship, follower_id: @user1.follower_id)
      expect(@relationships2).to be_valid
    end
  end
end

describe '各モデルとのアソシエーション' do
  let(:association) do
    described_class.reflect_on_association(target)
  end

  context '仮想モデルfollowerとのアソシエーション' do
    let(:target) { :follower }

    it 'Followerとの関連付けはbelongs_toであること' do
      expect(association.macro).to  eq :belongs_to
    end
  end

  context '仮想モデルfollowedとのアソシエーション' do
    let(:target) { :followed }

    it 'Followedとの関連付けはbelongs_toであること' do
      expect(association.macro).to  eq :belongs_to
    end
  end
end
