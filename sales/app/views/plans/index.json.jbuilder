json.array!(@plans) do |plan|
  json.extract! plan, :id, :user_id, :plan_ym, :newcar, :usedcar, :onemonth, :sixmonth, :years, :inspection, :insurance
  json.url plan_url(plan, format: :json)
end
