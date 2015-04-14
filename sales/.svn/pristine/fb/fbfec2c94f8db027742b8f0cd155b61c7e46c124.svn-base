class User < ActiveRecord::Base

# validation

 # 社員名
  validates :user_name,
    :presence => true,
    :length => { maximum: 20 }
 # ユーザーID
  validates :user_id,
    :presence => true,
    :uniqueness => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # ユーザーパスワード
  validates :user_password,
    :presence => true,
    :length => { maximum: 16 },
    :format => { with: /\A[a-z0-9]+\z/i }
 # 担当コード
  validates :emp_no,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, less_than: 1000, allow_blank: true}
 # 表示順
  validates :display_order,
    :numericality => {only_integer: true, greater_than_or_equal_to: 0, less_than: 1000, allow_blank: true}

end
