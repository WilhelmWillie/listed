class PagesController < ApplicationController
  def home
  end

  def recent
    if params[:page].present?
      @lists = List.paginate(:page => params[:page]).order('created_at DESC')
    else
      redirect_to '/recent/1'
    end
  end

  def top
    if params[:page].present?
      @lists = List.paginate(:page => params[:page]).order('likes_count DESC')
    else
      redirect_to '/top/1'
    end
  end

  def random
    redirect_to List.order("RANDOM()").first
  end
end
