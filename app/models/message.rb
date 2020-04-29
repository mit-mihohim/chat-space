class Message < ApplicationRecord
  belogs_to :group
  belogs_to :user

  validates :body, presence: true, unless: image?
end