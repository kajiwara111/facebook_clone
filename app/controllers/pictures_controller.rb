class PicturesController < ApplicationController
    before_action :login_check, only: [:index, :new, :confirm, :create]
    
    def index
        @pictures = Picture.all.order(created_at: "DESC")
    end
    
    def new
        if params[:back]
            @picture = Picture.new(picture_params)
        else
            @picture = Picture.new
        end
    end

    def confirm
        @picture = Picture.new(picture_params)
    end

    def create
        #@picture = Picture.new(picture_params)
        #@picture.user_id = current_user.id
        @picture = current_user.pictures.build(picture_params)
        if @picture.save
            flash[:notice] = '画像を投稿しました'
            redirect_to pictures_path
        else
            flash.now[:alert] = '画像の投稿に失敗しました'
            render 'new'
        end
    end

    private

    def picture_params
        params.require(:picture).permit(:image, :image_cache, :content)
    end

    def login_check
        unless logged_in?
            flash[:alert] = "ログインしてください"
            redirect_to new_session_path
        end
    end

end
