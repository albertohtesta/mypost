class Post < ApplicationRecord
  PER_PAGE = 3
  include Voteable
  include Sluggable
  default_scope { order('created_at ASC')}

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  sluggable_column :title

end
