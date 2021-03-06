class PostsController < ApplicationController

    before_action :authenticate_user!

    def index
        @posts = Post.all

        if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @posts = Post.joins(:user).where("title LIKE ? OR genre = ? ", "%#{search}%", "%#{search}%")
        elsif params[:genre] != nil && params[:genre] != ''
            search = params[:genre]
            @posts = Post.where("genre = ? ",params[:genre])
        else
            @posts = Post.all
        end
        
    end

    def link
    end

    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id

        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action =>"new"
        end
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            redirect_to :action => "show", :id => post.id
        else
            redirect_to :action => "new"
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
    end

    private 
    def post_params
        params.require(:post).permit(:title, :body, :image, :genre, :price)
    end
end
