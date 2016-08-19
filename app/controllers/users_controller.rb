class UsersController < ApplicationController
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    @lists = @user.lists.order('created_at DESC')
    @comments = Comment.where(:user_id => @user)
    @likes = Like.where(:user_id => @user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'Succesfully signed up, welcome to Listed!' 
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :display_name, :password, :password_confirmation)
    end
end
