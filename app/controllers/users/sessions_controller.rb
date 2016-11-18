class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  def dashboard
    if current_user.role == 'Admin'
      @users = User.all
      @communities = Community.all
      render 'admin_dashboard'
    elsif current_user.role == 'Borrower'
      if params.has_key?(:search_name)
        @communities = Community.where(:name => :search_name)
      else
        @communities = Community.all
      end
      render 'borrower_dashboard'
    else
      @community = current_user.community
      if !current_user.community.nil?
        @community.images.build
      end
      render 'community_dashboard'
    end
  end
  def show
    @user = User.find(params[:id])
  end


end
