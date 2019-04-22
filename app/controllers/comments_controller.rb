class CommentsController < ApplicationController
    #http_basic_authenticate_with name: "albert", password: "123123", only: [:destroy]
    before_action :require_user, only: [:index, :show]
    def create 
        @username = User.find(session[:user_id])
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        redirect_to post_path(@post)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    private def comment_params
        params.require(:comment).permit(:username, :body).merge(user_id: current_user.id)
    end
end
