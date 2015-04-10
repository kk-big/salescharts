class Result < ActiveRecord::Base
  
  belongs_to :user, :foreign_key => "user_id", :primary_key => "user_id"
  
# validation
 # ユーザーID
  validates :user_id,
    :presence => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # 基準年月日
  validates :result_date, 
    :presence => true,
    uniqueness: { scope: [:user_id] },
    :length => { is: 8 }
 # 商談件数
   validates :negotiations,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 査定件数
   validates :assessment,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 試乗件数
   validates :testdrive,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注新規台数
   validates :newcar_new,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注代替台数
   validates :newcar_replace,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注増車台数
   validates :newcar_add,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注紹介台数
   validates :newcar_introduce,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車業販台数
   validates :wholesale,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注現金台数
   validates :newcar_cash,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注クレジット台数
   validates :newcar_credit,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車受注残クレジット台数
   validates :newcar_credit_re,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車登録当月可台数
   validates :registration_possible,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 新車登録当月実績台数
   validates :registration_result,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 中古車直版受注台数
   validates :usedcar,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 初回1ヶ月点検実施台数
   validates :onemonth,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 初回6ヶ月点検実施台数
   validates :sixmonth,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 12点検・24点検実施台数
   validates :years,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 12点検・24点検対象外実施台数
   validates :years_not,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 車検実施台数
   validates :inspection,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 車検対象外実施台数
   validates :inspection_not,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 任意保険新規件数
   validates :insurance_new,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 任意保険継続件数
   validates :insurance_renew,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}
 # 任意保険解約件数
   validates :insurance_cancel,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, allow_blank: true}

 # 関連チェック
   # 新車台数
   validate :check_newcar_cash
   def check_newcar_cash
     if (nil_to_zero(newcar_new) + nil_to_zero(newcar_replace) + nil_to_zero(newcar_add) + nil_to_zero(newcar_introduce)) !=
        (nil_to_zero(newcar_cash) + nil_to_zero(newcar_credit))
       errors.add(:newcar_cash,"：支払方法の合計は受注の合計と一致させて下さい。")
       errors.add(:newcar_credit,"：支払方法の合計は受注の合計と一致させて下さい。")
     end
   end

   # 残クレ台数
   validate :check_newcar_credit_re
   def check_newcar_credit_re
     if nil_to_zero(newcar_credit) < nil_to_zero(newcar_credit_re)
       errors.add(:newcar_credit_re,"＜新車受注（クレジット）として下さい。")
     end
   end

# nilをゼロに変換
   def nil_to_zero(param)
     if param.blank?
       return 0 
     else
       return param
     end
   end


# 検索フォーム
  def self.search(result_date_from, result_date_to, user_id) #self.でクラスメソッドとしている
  # 基準日
    if result_date_from.blank? or result_date_to.blank? 
      results = Result.all.order('result_date asc, user_id asc') #全て表示。
    else
      if result_date_from.blank?
        results = Result.where(['result_date <= ?', result_date_to]).order('result_date asc, user_id asc')
      else
        if result_date_to.blank?
          results = Result.where(['result_date >= ?', result_date_from]).order('result_date asc, user_id asc')
        else
          results = Result.where(['result_date >= ? and result_date <= ?', result_date_from, result_date_to]).order('result_date asc, user_id asc')
        end
      end
    end
    
  # 社員
    if user_id.blank?
    else
      if user_id[:user_id].blank?
      else
        results = results.where(['results.user_id = ?', user_id[:user_id]]).order('result_date asc')
      end
    end

    return results

  end

end
