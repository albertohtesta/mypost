class PostsController < ApplicationController

	before_action :set_post, only: [:show, :edit, :update, :vote]
	before_action :require_creator, only: [:edit, :update]
	before_action :require_user, except: [:show, :index]
	def index
		#@posts = Post.all.sort_by{|x| x.total_votes}.reverse
		@posts = Post.limit(Post::PER_PAGE).offset(params[:offset]).sort_by{|x| x.total_votes}.reverse 
		@pages = (Post.all.size.to_f / Post::PER_PAGE).ceil
	end

	def new
		@post = Post.new
	end

	def show
		@comment = Comment.new
	end

	def create
		@post = Post.new(post_params)
		@post.creator = current_user
		if @post.save
			flash[:notice] = 'El post se ha creado'
			redirect_to posts_path
		else
			render :new
		end
	end
	def edit; end

	def update
		if @post.update(post_params)
			flash[:notice] = 'El post se ha actualizado'
			redirect_to post_path(@post)
		else
			render :edit
		end
	end

	def vote
		@vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
		
		respond_to do |format|
			format.html do
				if @vote.valid?
					flash[:notice] = "Your vote was counted"
				else
					flash[:alert] = "You can only vote on a post once"
				end
				redirect_back(fallback_location: root_path)
			end
			format.js # aqui ejecuta vote.js.erb
		end

	end

	private

	def post_params
		params.require(:post).permit(:title, :url, :description, category_ids:[])
	end
	
	def set_post
		@post = Post.find_by(slug: params[:id])
	end

	def require_creator
		access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
	end
end