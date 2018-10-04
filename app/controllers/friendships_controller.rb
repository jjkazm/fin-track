class FriendshipsController < ApplicationController
  def destroy
    friend = User.find(params[:id])
    @unwanted_friend = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    @unwanted_friend.destroy
    flash[:danger] = "#{friend.full_name} was succesfully removed from your friends"
    redirect_to my_friends_path
  end
end
