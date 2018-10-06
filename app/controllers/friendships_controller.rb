class FriendshipsController < ApplicationController
  def destroy
    friend = User.find(params[:id])
    @unwanted_friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    @unwanted_friendship.destroy
    flash[:danger] = "Friend was succesfully removed"
    redirect_to my_friends_path
  end
end
