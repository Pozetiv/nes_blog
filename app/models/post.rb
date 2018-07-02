class Post < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
  friendly_id :title, use: :slugged

  validates :content, :title, :short_body, presence: true, length: {minimum: 2}
  validates :category_id, presence: true


end
