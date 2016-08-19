class DashboardController < ApplicationController
  # If the user is logged in, we show a customized user dashboard for tracking lists and interactions
  # Otherwise, we display a generic landing page to get users to sign up
  def home
    if current_user
      @lists = current_user.lists.order('created_at DESC')
      @recent = List.all.order('created_at DESC').limit(5)

      render 'home'
    else
      @recent = List.all.order('created_at DESC').limit(3)
      @top = List.all.order('likes_count DESC').limit(3)
      render 'pages/home'
    end
  end
end
