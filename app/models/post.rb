class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  mount_uploader :images, ImagesUploader

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 1 }, presence: true
  validates :body, length: { minimum: 1 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
