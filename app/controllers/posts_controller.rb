class PostsController < ApplicationController
    #http_basic_authenticate_with name: "albert", password: "123123", except: [:index, :show]
    before_action :require_user, only: [:index, :show]
    def index
        @posts = Post.all
        #@post = Post.find(params[:post_id])
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        # render plain: params[:post].inspect
        @post = Post.new(post_params) #post tuh model
        
        if(@post.save)
            redirect_to @post
        else
            render 'new'
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if(@post.update(post_params))
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    private def post_params
        params.require(:post).permit(:title,:body).merge(user_id: current_user.id)
    end
end
