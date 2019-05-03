class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        user = User.new(user_params)
        if user.save
            login!(user)
            redirect_to user_url(user) #whatever the home page is
        else
            flash.now[:errors] = ["invalid username or password"]
            render :new
        end
    end

    def edit
        @user = User.find_by(id: params[:id])

        if @user
            render :edit
        else
            redirect_to users_url
        end
    end

    def update
        user = User.find_by(id: params[:id])
        
        if user.update(user_params)
            redirect_to user_url(user) #whatever the home page is
        else
            
            flash.now[:errors] = user.errors.full_messages
            render :edit
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy
        redirect_to users_url
    end

    def show
        @user = User.find_by(id: params[:id])

        if @user
            render :show
        else
            redirect_to users_url
        end
    end

    def index
        render :index
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

end