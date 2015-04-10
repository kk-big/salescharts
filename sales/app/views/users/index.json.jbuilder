json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :user_password, :user_name, :emp_no, :position, :job, :role, :delete_flag
  json.url user_url(user, format: :json)
end
