class UserStocksController < ApplicationController

  def create
    stock = Stock.find_by_ticker(params[:ticker])
    if stock.blank?
      stock = Stock.new_from_search(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "#{@user_stock.stock.name} has been added to the portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:danger] = "Stock was succesfully romoved from portfolio"
    redirect_to my_portfolio_path
  end

end
