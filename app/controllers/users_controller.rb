class UsersController < ApplicationController
  require 'digest'

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params.require(:user).permit(:nickname, :email, :password, :country))
    
    if @user.save 
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(params.require(:user).permit(:nickname, :email, :password, :country))
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end
  
  def login
    
  end

  def validateLogin
    @user = User.find_by(nickname: params[:nickname])
    if @user == nil
      flash[:danger] = 'The credentials provided do not correspond to any user.'
      redirect_to login_path
    else
      @pass = params[:password]
      @pass = Digest::SHA256.new << @pass
      if @pass == @user.password
         session[:user_id] = @user.id
         flash[:success] = 'You are logged in as ' + @user.nickname
         if @user.userType == 1
          redirect_to admin_index_path
         else
          redirect_to registered_path
         end
      else
        flash[:danger] = 'The credentials provided do not correspond to any user.'
        redirect_to login_path
      end
    end
  end
  
  def registered
    
  end
  
end
