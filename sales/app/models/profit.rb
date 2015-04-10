class Profit < ActiveRecord::Base
  
  belongs_to :user, :foreign_key => "user_id", :primary_key => "user_id"

# validation
 # ユーザーID
  validates :user_id,
    :presence => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # 基準年月
  validates :profit_ym, 
    :presence => true,
    uniqueness: { scope: [:user_id] },
    :length => { is: 6 },
    :numericality => {only_integer: true}
 # 新車売上台数
   validates :number_of_newcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車売上金額
  validates :sales_of_newcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車粗利金額
  validates :profit_of_newcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 中古車売上台数
  validates :number_of_usedcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 中古車売上金額
  validates :sales_of_usedcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 中古車粗利金額
  validates :profit_of_usedcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # サービス売上台数
  validates :number_of_service,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # サービス売上金額
  validates :sales_of_service,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # サービス粗利金額
  validates :profit_of_service,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}

# 検索フォーム(日付)
  def self.search(profit_ym_from, profit_ym_to, user_id) #self.でクラスメソッドとしている
    if profit_ym_from.blank? and profit_ym_to.blank? 
      profits = Profit.all.order('profit_ym asc, user_id asc') #全て表示。
    else
      if profit_ym_from.blank?
        profits = Profit.where(['profit_ym <= ?', profit_ym_to]).order('profit_ym asc, user_id asc')
      else
        if profit_ym_to.blank?
          profits = Profit.where(['profit_ym >= ?', profit_ym_from]).order('profit_ym asc, user_id asc')
        else
          profits = Profit.where(['profit_ym >= ? and profit_ym <= ?', profit_ym_from, profit_ym_to]).order('profit_ym asc, user_id asc')
        end
      end
    end
    
    if user_id.blank?
    else
      if user_id[:user_id].blank?
      else
        profits = profits.where(['profits.user_id = ?', user_id[:user_id]]).order('profit_ym asc')
      end
    end

    return profits

  end

end
