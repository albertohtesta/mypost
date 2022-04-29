class Admin::VideosController < AdminController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
    @categories = Category.all
  end

  def create
    @video = Video.new(video_params)
    @categories = Category.all

    if @video.save
      flash[:success] = "You have successfully added the video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You cannot add this video. Please check errors."
      render 'new'
    end
  end


  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :large_cover, :small_cover, :cover_image_url)
  end

  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that"
      redirect_to home_path
    end
  end

end
