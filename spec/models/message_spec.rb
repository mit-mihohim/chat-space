require 'rails_helper'

RSpec.describe Message, type: :model do
  
  describe "#create" do
    #bodyを保存できる場合
    context 'messageを保存できる場合' do
      # bodyがあれば保存できる
      it "bodyがあれば保存できる" do
        expect(build(:message, image: nil)).to be_valid
      end

      # imageがあれば保存できる
      it "imageがあれば保存できる" do
        expect(build(:message, body: nil)).to be_valid
      end
      
      # bodyとimageがあれば保存できる
      it "bodyとimageがあれば保存できる" do
        expect(build(:message)).to be_valid
      end
    end

    # メッセージを保存できない場合
    context 'messageを保存できる場合' do
      # bodyもimageも無いと保存できない
      it "bodyもimageもないと保存できない" do
        message = build(:message, body: nil, image: nil)
        message.valid?
        expect(message.errors[:body]).to include("を入力してください")
      end

      # group_idが無いと保存できない
      it "group_idが無いと保存できない" do
        message = build(:message, group: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      # user_idが無いと保存できない
      it "user_idが無いと保存できない" do
        message = build(:message, user: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end