class FavoritesController < ApplicationController
    def index
        #favorites = current_user.favorites
        #@pictures = favorites.picture
        #うえの２行で取得できないのはなぜ？結局use modelにfavorite_picturesアソシエーション定義した
        @pictures = current_user.favorite_pictures
    end 
    def create
        #picture_id変数はお気に入り登録のviewで定義して送っている
        #質問　下記は1行のテーブルをイメージすればよい？
        favorite = current_user.favorites.create(picture_id: params[:picture_id])
        
        #favorite.pictureでいまお気に入り登録したpicture_idと同じIDのpicture table 引っ張ってくる
        #そのテーブルに対してuser.nameで名前とってくる
        #favoriteはcurrent_useのuset_idといまお気に入りしたpicture_idの１行のテーブル？
        redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんのブログをお気に入り登録しました"
    end

    def destroy
        #destroyはルーティングが/favorites/:idとなっているため、idで送られてくるようにviewで指定した。
        favorite = current_user.favorites.find_by(id: params[:id]).destroy
        redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんのブログをお気に入り解除しました"
    end
end
