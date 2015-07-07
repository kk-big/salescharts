class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

  # 検索フォーム
    require "date"
    #今日
    d = Date.today
    #月初
    start_date = Date::new(d.year,d.month, 1)
    default_date_from = start_date.year.to_s + sprintf("%02d", start_date.month).to_s + sprintf("%02d", start_date.day).to_s 

    #月末
    end_date = start_date >> 1
    end_date = end_date - 1
    default_date_to = end_date.year.to_s + sprintf("%02d", end_date.month).to_s + sprintf("%02d", end_date.day).to_s 

    if params[:result_date_from].nil? 
      #販売活動登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        result_date_from = session[:cond_result_date_from]
        @result_date_from = session[:cond_result_date_from]
      else
        result_date_from = default_date_from
        @result_date_from = default_date_from
      end
    elsif params[:result_date_from].empty?
      result_date_from = ''
      @result_date_from = ''
    else
      result_date_from = params[:result_date_from]
      @result_date_from = params[:result_date_from]
    end

    if params[:result_date_to].nil? 
      #販売活動登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        result_date_to = session[:cond_result_date_to]
        @result_date_to = session[:cond_result_date_to]
      else
        result_date_to = default_date_to
        @result_date_to = default_date_to
      end
    elsif params[:result_date_to].blank? 
      result_date_to = ''
      @result_date_to = ''
    else
      result_date_to = params[:result_date_to]
      @result_date_to = params[:result_date_to]
    end

    if params[:result].blank? 
      #販売活動登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        params[:result] = session[:cond_result_user_id]
        user_id = params[:result]
        #条件設定がなかった時
        if user_id.blank?
          @user_id = ''
        else
          @user_id = params[:result][:user_id]
        end
        params[:result] = ''
      else
        user_id = ''
        @user_id = ''
      end
    else
      user_id = params[:result]
      @user_id = params[:result][:user_id]
    end

#    @results = Result.search(result_date_from, result_date_to, user_id)
    @results = Result.joins(:user).order('users.display_order').search(result_date_from, result_date_to, user_id)

    #検索条件をセッションに格納して保持
    session[:cond_result_date_from] = result_date_from
    session[:cond_result_date_to] = result_date_to
    session[:cond_result_user_id] = user_id

  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    update_result_params = result_params
    update_result_params[:result_ym] = result_params[:result_date][0,6]
#    @result = Result.new(result_params)
    @result = Result.new(update_result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: '販売活動を登録しました。' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    update_result_params = result_params
    update_result_params[:result_ym] = result_params[:result_date][0,6]
    respond_to do |format|
#      if @result.update(result_params)
      if @result.update(update_result_params)
        format.html { redirect_to @result, notice: '販売活動を変更しました。' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: '販売活動を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:user_id, :result_ym, :result_date, :negotiations, :assessment, :testdrive, :newcar_new, :newcar_replace, :newcar_add, :newcar_introduce, :wholesale, :newcar_cash, :newcar_credit, :newcar_credit_re, :inspection_pack, :registration_possible, :registration_plan_update, :registration_result, :usedcar, :onemonth, :sixmonth, :years, :years_not, :inspection, :inspection_not, :insurance_new, :insurance_renew, :insurance_cancel)
    end
end
