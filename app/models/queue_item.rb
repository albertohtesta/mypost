class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_numericality_of :position, { only_integer: true }

  delegate :title, to: :video, prefix: :video
  delegate :category, to: :video
#  def video_title
#    video.title
#  end

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
     review = Review.create(user_id: user.id, video_id: video.id, rating: new_rating)
     review.save(validate: false) # para que aqui no valide que no hay content
    end
  end

  def category_name
    category.name
  end

  # 等价于  delegate :category, to: :video
#  def category
#    video.category
#  end

  private
  def review
    @review ||= Review.find_by(user_id: user.id, video_id: video.id)
  end
end