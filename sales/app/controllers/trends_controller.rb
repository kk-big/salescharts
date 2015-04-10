class TrendsController < ApplicationController
  before_action :set_trend, only: [:show, :edit, :update, :destroy]
  before_action :check_chart, only: [:create]

  # GET /trends
  # GET /trends.json
  def index
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

    require "date"
    d = Date.today

    #6ヶ月前
    default_date_from = d << 5
    default_ym_from = default_date_from.year.to_s + sprintf("%02d", default_date_from.month).to_s 

    #今月
    default_ym_to = d.year.to_s + sprintf("%02d", d.month).to_s 

    if params[:trend_ym_from].nil? 
      param_ym_from = default_ym_from
      @trend_ym_from = default_ym_from
    elsif params[:trend_ym_from].empty?
      param_ym_from = default_ym_from
      @trend_ym_from = default_ym_from
    else
      param_ym_from = params[:trend_ym_from]
      @trend_ym_from = params[:trend_ym_from]
    end

    if params[:trend_ym_from].nil? 
      param_ym_to = default_ym_to
      @trend_ym_to = default_ym_to
    elsif params[:trend_ym_to].empty? 
      param_ym_to = default_ym_to
      @trend_ym_to = default_ym_to
    else
      param_ym_to = params[:trend_ym_to]
      @trend_ym_to = params[:trend_ym_to]
    end

    #日付チェック　未来はNG
    if param_ym_to > default_ym_to 
      redirect_to trends_path, :notice => "今日以前を指定してください。"
      return
    end

    #日付チェック　MAX１２ヶ月
    param_date_to = Date::new(param_ym_to[0,4].to_i, param_ym_to[4,2].to_i, 1)
    date_from_before12 = param_date_to << 11
    ym_from_before12 = date_from_before12.year.to_s + sprintf("%02d", date_from_before12.month).to_s 
    if param_ym_from < ym_from_before12 
      redirect_to trends_path, :notice => "期間は12ヶ月以内にしてください。"
      return
    end

    @trends = Plan.find_by_sql(['
      select
        usplre.uid as user_id, usplre.user_name, usplre.plan_ym, usplre.customer, usplre.registration_plan, usplre.display_order, sum(negotiations) as negotiations, sum(assessment) as assessment, sum(testdrive) as testdrive, sum(pl_newcar) as pl_newcar, 
        sum(newcar_new) as newcar_new, sum(newcar_replace) as newcar_replace, sum(newcar_add) as newcar_add, sum(newcar_introduce) as newcar_introduce, sum(newcar_credit) as newcar_credit, sum(newcar_credit_re) as newcar_credit_re,
        sum(registration_possible) as registration_possible, sum(registration_result) as registration_result, sum(pl_usedcar) as pl_usedcar, sum(usedcar) as usedcar, sum(pl_onemonth) as pl_onemonth, sum(onemonth) as onemonth, sum(pl_sixmonth) as pl_sixmonth, sum(sixmonth) as sixmonth, sum(pl_years) as pl_years, sum(years) as years,
        sum(years_not) as years_not, sum(pl_inspection) as pl_inspection, sum(inspection) as inspection, sum(inspection_not) as inspection_not, sum(insurance_new) as insurance_new, sum(pl_insurance) as pl_insurance, sum(insurance_renew) as insurance_renew,
        sum(insurance_cancel) as insurance_cancel
       from 
      ((select us.user_id as uid, us.user_password, us.user_name, us.emp_no, us.position, us.job, us.role, us.display_order, us.delete_flag,
       pl.user_id, pl.plan_ym as plan_ym, pl.customer as customer, pl.newcar as pl_newcar, pl.registration_plan as registration_plan, pl.usedcar as pl_usedcar, pl.onemonth as pl_onemonth, pl.sixmonth as pl_sixmonth, pl.years as pl_years, 
       pl.inspection as pl_inspection, pl.insurance as pl_insurance
       from users us left join plans pl on us.user_id = pl.user_id) as uspl
       full outer join 
      (select user_id, result_ym, 
       sum(negotiations) as negotiations, sum(assessment) as assessment, sum(testdrive) as testdrive,
       sum(newcar_new) as newcar_new, sum(newcar_replace) as newcar_replace, sum(newcar_add) as newcar_add, sum(newcar_introduce) as newcar_introduce, 
       sum(newcar_credit) as newcar_credit, sum(newcar_credit_re) as newcar_credit_re, sum(registration_possible) as registration_possible, sum(registration_result) as registration_result,
       sum(usedcar) as usedcar,
       sum(onemonth) as onemonth, sum(sixmonth) as sixmonth, sum(years) as years, sum(years_not) as years_not,
       sum(inspection) as inspection, sum(inspection_not) as inspection_not,
       sum(insurance_new) as insurance_new, sum(insurance_renew) as insurance_renew, sum(insurance_cancel) as insurance_cancel
       from results group by user_id , result_ym) re
       on uspl.uid = re.user_id and uspl.plan_ym = re.result_ym) as usplre
       where usplre.plan_ym >=? and usplre.plan_ym <= ?
       group by usplre.uid, usplre.user_name, usplre.plan_ym, usplre.customer, usplre.registration_plan, usplre.display_order order by usplre.display_order, usplre.uid, usplre.plan_ym
      ',param_ym_from, param_ym_to ])

  end

  # GET /trends/1
  # GET /trends/1.json
  def show
  end

  # GET /trends/new
  def new
    @trend = Trend.new
  end

  # GET /trends/1/edit
  def edit
  end

  # POST /trends
  # POST /trends.json
  def create
    @trend = Trend.new(trend_params)

    respond_to do |format|
      if @trend.save
        format.html { redirect_to @trend, notice: 'Trend was successfully created.' }
        format.json { render :show, status: :created, location: @trend }
      else
        format.html { render :new }
        format.json { render json: @trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trends/1
  # PATCH/PUT /trends/1.json
  def update
    respond_to do |format|
      if @trend.update(trend_params)
        format.html { redirect_to @trend, notice: 'Trend was successfully updated.' }
        format.json { render :show, status: :ok, location: @trend }
      else
        format.html { render :edit }
        format.json { render json: @trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trends/1
  # DELETE /trends/1.json
  def destroy
    @trend.destroy
    respond_to do |format|
      format.html { redirect_to trends_url, notice: 'Trend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trend
      @trend = Trend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trend_params
      params[:trend]
    end

    # 対象データ存在チェック
    def check_chart
      if params[:check_on].nil? 
        redirect_to charts_path, :notice => "1件以上データを選択してください。"
        return
      end
    end

end
