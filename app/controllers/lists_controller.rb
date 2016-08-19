class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :user_can_edit?]
  before_action :check_logged_in, only: [:new, :create, :update, :destroy, :like]

  helper_method :user_can_edit?, :user_likes_list?

  def index
    @lists = List.all
  end

  def show
    @items = @list.items.order(:order)
    @comments = @list.comments.order('created_at')

    @item = Item.new
    @comment = Comment.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    redirect_to '/', notice: 'List was successfully destroyed.'
  end

  def like
    @list = List.find(params[:list_id])

    if user_likes_list?
      l = Like.where(:user_id => current_user, :list_id => @list).first
      
      if l.destroy
        render json: { :like_count => @list.likes_count - 1 }
      else
        render json: { :error => 'An error occured'}
      end
    else
      l = Like.new
      l.user = current_user
      l.list = @list

      if l.save 
        render json: { :like_count => @list.likes_count }
      else
        render json: { :error => 'An error occured' }
      end
    end
  end

  private
    # Denies a user from continuing the action if they aren't logged in
    def check_logged_in
      unless current_user
        redirect_to '/login'
      end
    end

    # Returns true if the user logged in is the same as the list creator
    def user_can_edit?
      current_user == @list.user
    end

    # Returns true if the user logged in likes the current list
    def user_likes_list?
      Like.exists?(:user_id => current_user, :list_id => @list)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :description, :slug)
    end
end
