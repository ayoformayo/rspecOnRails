class Admin::PostsController < ApplicationController
  USER, PASSWORD = 'geek', 'jock'

  before_filter :authentication_check, :only => [:index]

  def index

    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = "Post was successfully saved."
      redirect_to admin_post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    #@post.update(params[:post])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to admin_post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])

    post.destroy

    redirect_to admin_posts_path
  end

  private
    def authentication_check
      authenticate_or_request_with_http_basic do |user, password|
        user == USER && password == PASSWORD
      end
    end
end
