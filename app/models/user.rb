class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    return "#{ first_name} #{ last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

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

  def self.search(param, columns)
    param.strip!
    param.downcase!
    result = []
    columns.each do |col|
      result += matches(col, param)
    end
    return nil unless result
    result.uniq
  end

  def self.matches(column, required)
    where("#{column} like ?", "%#{required}%")
  end
end
