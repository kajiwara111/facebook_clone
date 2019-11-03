class PicturesController < ApplicationController
    #%iはシンボル記法の配列作成する
    #[,]は不要なので注意。
    before_action :login_check, only: %i[index new confirm create]
    before_action :set_params, only: %i[edit update]

    def index
        @pictures = Picture.all.order(created_at: "DESC")
        #@favorite = current_user.favorites.find_by(picture_id)
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

    def edit
        #@picture = Picture.find(params[:id])
        #binding.pry
    end

    def update
        #@picture = Picture.find(params[:id])
        if @picture.update(picture_params)
            flash[:notice] = "投稿を編集しました"
            redirect_to pictures_path
        else
            render :edit
        end
    end

    private

    def picture_params
        params.require(:picture).permit(:image, :image_cache, :content)
    end

    def set_params
        @picture = Picture.find(params[:id])
    end

    def login_check
        unless logged_in?
            flash[:alert] = "ログインしてください"
            redirect_to new_session_path
        end
    end

end
