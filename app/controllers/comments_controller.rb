class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find_by(slug: params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user
		if @comment.save
			flash[:notice] = 'Tu comentario ha sido añadido'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		comment = Comment.find(params[:id])
		vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
		if vote.valid?
			flash[:notice] = 'Tu voto fue acumulado'
		else
			flash[:alert] = 'Solo puedes votar una vez'
		end
		redirect_back(fallback_location: root_path)
	end
end