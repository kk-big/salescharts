module SalesHelper

# 計画進度（実績-計画）を返す
  def progress(param1, param2)
    if param1.nil? or param2.nil?
      return 0 
    else
      return param2 - param1
    end
  end

# 計画進度（param2/param1）を返す
  def progress_per(param1, param2)
    if param1.nil? or param2.nil? then
      return 0 
    else
      if param1 == 0 or param2 == 0 then
        return 0 
      else
         return param2.quo( param1) * 100
      end
    end   
  end

# NG率を返す（(param1-param2)/param1）
  def ng_per(param1, param2)
    if param1.nil? or param2.nil? then
      return 0 
    else
      if param1 == 0 then
        return 0 
      elsif param1 <= param2 
        return 0 
      else
        ng = param1 - param2         
        return ng.quo(param1) * 100
      end
    end   
  end

# 利益率（粗利/売上）を返す
  def profit_per(param1, param2)
    if param1.blank? or param2.blank? then
      return 0 
    else
      if param1 == 0 or param2 == 0 then
        return 0 
      else
         return param1.quo(param2) * 100
      end
    end   
  end

# 金額を千円単位で返す
  def unit_thousand(param)
    if param.blank? then
      return 0 
    else
      return param.div(1000)
    end   
  end

# 数値を件で返す
  def unit_ken(param)
    if param.blank? then
    else
      return number_to_currency(param, unit: '件', precision: 0)
    end   
  end

# 数値を台で返す
  def unit_dai(param)
    if param.blank? then
    else
      return number_to_currency(param, unit: '台', precision: 0)
    end   
  end

# 計画進度100％達成ならtrueを返す
  def equal100(param)
    if param.blank? or param < 100 then
      return false
    else
      return true
    end   
  end

# 計画進度70％達成ならtrueを返す
  def over70(param)
    if param.blank? or param < 70 then
      return false
    else
      return true
    end   
  end

# 計画進度50％達成ならtrueを返す
  def over50(param)
    if param.blank? or param < 50 then
      return false
    else
      return true
    end   
  end

# NG率0％ならtrueを返す
  def equal0(param)
    if param.blank? or param > 0 then
      return false
    else
      return true
    end   
  end

end
