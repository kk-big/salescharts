class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :write_access_log, except: [:set_action_name]
  after_action :destroy_action_name, except: [:set_action_name]
  
  def current_user
    @current_user = session[:user_id] if session[:user_id]
  end

  helper_method :current_user

  protected
    def check_login
      redirect_to new_login_path if session[:user_id].nil?
    end

    def write_access_log
       return unless session[:action_name]
       access_log_params = {}
       access_log_params[:ip_address] = request.remote_ip.to_s
       access_log_params[:user_id] = session[:user_id].to_s
       access_log_params[:url] = request.fullpath.to_s
       access_log_params[:action] = session[:action_name].to_s
       access_log_params[:parameters] = params.to_s
#       access_log_params[:operation_time] = Time.now
       AccessLog.create(access_log_params)
    end
    
    def destroy_action_name
        session[:action_name] = nil
    end

end
