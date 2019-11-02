class UsersController < ApplicationController
    before_action :login_check, only: [:show]

    def new
        @user = User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "アカウントを作成しました。ログインしてください"
            redirect_to new_session_path
        else
            render 'new'
        end
    end

    def show
        @user = User.find(params[:id])
        @user_feeds = @user.pictures 
    end

    def edit

    end
    
    def update

    end

    def destroy

    end
  
    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def login_check
        unless logged_in?
            flash[:alert] = "ログインしてください"
            redirect_to new_session_path
        end
    end

end