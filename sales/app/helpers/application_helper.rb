module ApplicationHelper

# nav bar リンクアクティブ
  def add_active(name)
    return "active" if name.include?(controller.controller_name)
  end

# 年月をスラッシュ編集
  def yyyymm_slash(yyyymm)
    if yyyymm.blank?
    else
      return yyyymm[0,4] + '/' + yyyymm[4,2]
    end
  end

# 年月日をスラッシュ編集
  def yyyymmdd_slash(yyyymmdd)
    if yyyymmdd.blank?
    else
     return yyyymmdd[0,4] + '/' + yyyymmdd[4,2] + '/' + yyyymmdd[6,2]
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
 
end
