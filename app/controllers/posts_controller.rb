class PostsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "password", except: [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  # Show a post and its comments.
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  # Create a new post
  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  # Update a post
  def update
    @post = Post.find(params[:id])
 
    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render "edit"
    end
  end
  
  # Delete a post
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
 
    redirect_to posts_path
  end
  
  private
    def post_params
      params[:post].permit(:title, :text)
    end

end
