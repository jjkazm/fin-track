class StocksController < ApplicationController
  def search
    if params[:stock].blank?
      flash.now[:danger] = "You need to provide company's code"
    else
      @stock = Stock.new_from_search(params[:stock])
          flash.now[:danger] = "Provided code is invalid" unless @stock
    end
    respond_to do |format|
      format.js {render partial:'users/result'}
    end
  end
end
