class Inspection < ActiveRecord::Base
  
  belongs_to :user, :foreign_key => "user_id", :primary_key => "user_id"
  
# validation
 # ユーザーID
  validates :user_id,
    :presence => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # 基準年月日
  validates :inspection_ym, 
    :presence => true,
    uniqueness: { scope: [:user_id] },
    :length => { is: 6 },
    :numericality => {only_integer: true}
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

# 検索フォーム(日付)
  def self.search(inspection_ym_from, inspection_ym_to, user_id) #self.でクラスメソッドとしている
    if inspection_ym_from.blank? and inspection_ym_to.blank? 
      inspections = Inspection.all.order('inspection_ym asc, user_id asc') #全て表示。
    else
      if inspection_ym_from.blank?
        inspections = Inspection.where(['inspection_ym <= ?', inspection_ym_to]).order('inspection_ym asc, user_id asc')
      else
        if inspection_ym_to.blank?
          inspections = Inspection.where(['inspection_ym >= ?', inspection_ym_from]).order('inspection_ym asc, user_id asc')
        else
          inspections = Inspection.where(['inspection_ym >= ? and inspection_ym <= ?', inspection_ym_from, inspection_ym_to]).order('inspection_ym asc, user_id asc')
        end
      end
    end
    
    if user_id.blank?
    else
      if user_id[:user_id].blank?
      else
        inspections = inspections.where(['inspections.user_id = ?', user_id[:user_id]]).order('inspection_ym asc')
      end
    end

    return inspections

  end

end
