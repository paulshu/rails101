class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit

  end
# 附加作业

  def update
    @group = Group.find(params[:group_id])
    @group = Post.find(params[:id])
    @post.group = @group
    @post.user = current_user
    if @post.update(post_params)
      redirect_to posts_account_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group = Post.find(params[:id])

    @group.destroy
    redirect_to post_account_path(@group), alert: "Post deleted"
  end
#附加作业
  private

  def post_params
    params.require(:post).permit(:content)
  end

end
