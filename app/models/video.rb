class Video < ApplicationRecord
  belongs_to :category
  has_many :reviews, -> { order(:updated_at) }
  #validates :title, presence: true
  #validates :description, presence:true
  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
  	return [] if search_term.blank?
  	result = where("lower(title) LIKE ?", "%#{search_term.downcase}%").order("created_at DESC")
    result = result.to_a
  end

end
