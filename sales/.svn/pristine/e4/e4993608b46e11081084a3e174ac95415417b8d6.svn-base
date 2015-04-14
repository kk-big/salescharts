class Plan < ActiveRecord::Base
  
  belongs_to :user, :foreign_key => "user_id", :primary_key => "user_id"
#  has_many :results, :foreign_key => "user_id", :primary_key => "user_id"
#  has_many :results, :foreign_key => "result_ym", :primary_key => "plan_ym"
#  has_one :profits, :foreign_key => ["user_id", "plan_ym"], :primary_key => ["user_id", "profit_ym"]
  
# validation
 # ユーザーID
  validates :user_id,
    :presence => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # 基準年月
  validates :plan_ym, 
    :presence => true,
    uniqueness: { scope: [:user_id] },
    :length => { is: 6 },
    :numericality => {only_integer: true}
 # 顧客数
  validates :customer,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車計画台数
  validates :newcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車前月注残
  validates :newcar_balance,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車登録当月可
  validates :registration_possible,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車登録当月予定
  validates :registration_plan,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 中古車直版計画台数
  validates :usedcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 初回1ヶ月点検対象台数
  validates :onemonth,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
# 初回6ヶ月点検対象台数
  validates :sixmonth,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
# 12点検・24点検対象台数
  validates :years,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
# 車検対象台数
  validates :inspection,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
# 任意保険継続対象台数
  validates :insurance,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}

# 検索フォーム(日付)
  def self.search(plan_ym_from, plan_ym_to, user_id) #self.でクラスメソッドとしている
    if plan_ym_from.blank? and plan_ym_to.blank? 
      plans = Plan.all.order('plan_ym asc, user_id asc') #全て表示。
    else
      if plan_ym_from.blank?
        plans = Plan.where(['plan_ym <= ?', plan_ym_to]).order('plan_ym asc, user_id asc')
      else
        if plan_ym_to.blank?
          plans = Plan.where(['plan_ym >= ?', plan_ym_from]).order('plan_ym asc, user_id asc')
        else
          plans = Plan.where(['plan_ym >= ? and plan_ym <= ?', plan_ym_from, plan_ym_to]).order('plan_ym asc, user_id asc')
        end
      end
    end
    
    if user_id.blank?
    else
      if user_id[:user_id].blank?
      else
        plans = plans.where(['plans.user_id = ?', user_id[:user_id]]).order('plan_ym asc')
      end
    end

    return plans

  end

end