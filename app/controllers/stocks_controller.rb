class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_search(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial:'users/result'}
        end
      else
        respond_to do |format|
          flash.now[:danger] = "Provided code is invalid"
          format.js {render partial:'users/result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:danger] = "You need to provide company's code"
        format.js {render partial:'users/result'}
      end
    end
  end
end
