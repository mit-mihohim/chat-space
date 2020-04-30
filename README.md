# rails version
Rails 5.0.7.2
# ruby version
ruby 2.5.1p57 (2018-03-29 revision 63029)

# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false, pass.match(/[a-z\d]{8, }/i)|
### Association
- has_many :messages
- has_many :groups, through: :users_groups
- has_many :users_groups

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|body|text|null: false unless image|
|image|text| |
|date|integer|timestamps|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :users, through: :users_groups
- has_many :messages
- has_many :users_groups

## users_groupsテーブル(groups_users)
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group
