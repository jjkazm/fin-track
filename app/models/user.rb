class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_added?(ticker)
    stock = Stock.find_by_ticker(ticker)
    return false unless stock
    stocks.where(ticker: ticker).exists?
  end

  def above_limit?
    stocks.count>=10
  end

  def can_be_added?(ticker)
    return true  unless (already_added?(ticker) || above_limit?)
  end
end
