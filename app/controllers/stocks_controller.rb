class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_search(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial:'users/result'}
        end
      else
        flash[:danger] = "Provided code is invalid"
        redirect_to my_portfolio_path
      end
    else
      flash[:danger] = "You need to provide company's code"
      redirect_to my_portfolio_path
    end
  end
end
