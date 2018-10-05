class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  # def search
  #     @users = User.search(params[:search_param], ["first_name", "last_name", "email"])
  #     render json: @users
  # end


  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You need to provide friend's details"
    else
      @users = User.search(params[:search_param], ["first_name", "last_name", "email"])
      flash.now[:danger] = "No friends found" if @users.blank?
    end
    respond_to do |format|
      format.js {render partial:'friends/result'}
    end
  end
  

end
