class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

    require "date"
    d = Date.today
    default_ym = d.year.to_s + sprintf("%02d", d.month).to_s 

    if params[:sale_ym_from].nil? 
      param_ym_from = default_ym
      @sale_ym_from = default_ym
    elsif params[:sale_ym_from].empty?
      param_ym_from = '000000'
      @sale_ym_from = ''
    else
      param_ym_from = params[:sale_ym_from]
      @sale_ym_from = params[:sale_ym_from]
    end

    if params[:sale_ym_from].nil? 
      param_ym_to = default_ym
      @sale_ym_to = default_ym
    elsif params[:sale_ym_to].blank? 
      param_ym_to = '999999'
      @sale_ym_to = ''
    else
      param_ym_to = params[:sale_ym_to]
      @sale_ym_to = params[:sale_ym_to]
    end

    strsql = 'select
        usplrepr.uid as user_id, usplrepr.user_name, usplrepr.display_order, sum(pl_customer) as customer, sum(pl_newcar_balance) as newcar_balance, sum(pl_registration_plan) as registration_plan, 
        sum(negotiations) as negotiations, sum(assessment) as assessment, sum(testdrive) as testdrive,
        sum(pl_newcar) as pl_newcar, sum(newcar_new) as newcar_new, sum(newcar_replace) as newcar_replace, sum(newcar_add) as newcar_add, sum(newcar_introduce) as newcar_introduce,
        sum(wholesale) as wholesale,
        sum(newcar_credit) as newcar_credit, sum(newcar_credit_re) as newcar_credit_re,
        sum(registration_possible) as registration_possible, sum(registration_plan_update) as registration_plan_update, sum(registration_result) as registration_result, sum(pl_usedcar) as pl_usedcar, sum(usedcar) as usedcar, sum(pl_onemonth) as pl_onemonth, sum(onemonth) as onemonth, sum(pl_sixmonth) as pl_sixmonth, sum(sixmonth) as sixmonth, sum(pl_years) as pl_years, sum(years) as years,
        sum(years_not) as years_not, sum(pl_inspection) as pl_inspection, sum(inspection) as inspection, sum(inspection_not) as inspection_not, sum(insurance_new) as insurance_new, sum(pl_insurance) as pl_insurance, sum(insurance_renew) as insurance_renew,
        sum(insurance_cancel) as insurance_cancel, sum(number_of_newcar) as number_of_newcar, sum(sales_of_newcar) as sales_of_newcar, sum(profit_of_newcar) as profit_of_newcar,
        sum(number_of_usedcar) as number_of_usedcar, sum(sales_of_usedcar) as sales_of_usedcar, sum(profit_of_usedcar) as profit_of_usedcar,
        sum(number_of_service) as number_of_service, sum(sales_of_service) as sales_of_service, sum(profit_of_service) as profit_of_service,
        sum(all_sales) as all_sales,
        sum(all_profit) as all_profit,
        (case when sum(pl_newcar) <> 0 then (COALESCE(sum(newcar_new),0) + COALESCE(sum(newcar_replace),0) + COALESCE(sum(newcar_add),0) + COALESCE(sum(newcar_introduce),0)) / sum(pl_newcar) end ) as progress_newcar,
        (case when sum(pl_registration_plan) <> 0 then COALESCE(sum(registration_result),0) / sum(pl_registration_plan) end) as progress_registration,
        (case when sum(pl_usedcar) <> 0 then COALESCE(sum(usedcar),0) / sum(pl_usedcar) end) as progress_usedcar,
        (case when sum(pl_years) <> 0 then (COALESCE(sum(years),0) + COALESCE(sum(years_not),0)) / sum(pl_years) end) as progress_years,
        (case when sum(pl_inspection) <> 0 then (COALESCE(sum(inspection),0) + COALESCE(sum(inspection_not),0)) / sum(pl_inspection) end) as progress_inspection,
        (case when sum(pl_insurance) <> 0 then COALESCE(sum(insurance_renew),0) / sum(pl_insurance) end) as progress_insurance_renew,
        (case when sum(sales_of_newcar) <> 0 then COALESCE(sum(profit_of_newcar),0) / sum(sales_of_newcar) end) as per_profit_of_newcar,
        (case when sum(sales_of_usedcar) <> 0 then COALESCE(sum(profit_of_usedcar),0) / sum(sales_of_usedcar) end) as per_profit_of_usedcar,
        (case when sum(sales_of_service) <> 0 then COALESCE(sum(profit_of_service),0) / sum(sales_of_service) end) as per_profit_of_service,
        (case when sum(all_sales) <> 0 then COALESCE(sum(all_profit),0) / sum(all_sales) end) as per_all_profit
       from 
      (
      (((select us.user_id as uid, us.user_password, us.user_name, us.emp_no, us.position, us.job, us.role, us.delete_flag, us.display_order,
       pl.user_id, pl.plan_ym as plan_ym, pl.customer as pl_customer, pl.newcar as pl_newcar, pl.newcar_balance as pl_newcar_balance, pl.registration_plan as pl_registration_plan, pl.usedcar as pl_usedcar, pl.onemonth as pl_onemonth, pl.sixmonth as pl_sixmonth, pl.years as pl_years, 
       pl.inspection as pl_inspection, pl.insurance as pl_insurance
       from users us left join plans pl on us.user_id = pl.user_id) as uspl
       full outer join 
      (select user_id, result_ym, 
       sum(negotiations) as negotiations, sum(assessment) as assessment, sum(testdrive) as testdrive,
       sum(newcar_new) as newcar_new, sum(newcar_replace) as newcar_replace, sum(newcar_add) as newcar_add, sum(newcar_introduce) as newcar_introduce, 
       sum(wholesale) as wholesale,
       sum(newcar_credit) as newcar_credit, sum(newcar_credit_re) as newcar_credit_re, 
       sum(registration_possible) as registration_possible, sum(registration_plan_update) as registration_plan_update, sum(registration_result) as registration_result,
       sum(usedcar) as usedcar
       from results group by user_id , result_ym) re
       on uspl.uid = re.user_id and uspl.plan_ym = re.result_ym) as usplre
       full outer join 
      (select user_id, profit_ym, sum(number_of_newcar) as number_of_newcar, sum(sales_of_newcar) as sales_of_newcar, sum(profit_of_newcar) as profit_of_newcar,
       sum(number_of_usedcar) as number_of_usedcar, sum(sales_of_usedcar) as sales_of_usedcar, sum(profit_of_usedcar) as profit_of_usedcar,
       sum(number_of_service) as number_of_service, sum(sales_of_service) as sales_of_service, sum(profit_of_service) as profit_of_service,
       (sum(sales_of_newcar) + sum(sales_of_usedcar) + sum(sales_of_service)) as all_sales,
       (sum(profit_of_newcar) + sum(profit_of_usedcar) + sum(profit_of_service)) as all_profit
       from profits group by user_id , profit_ym) as pr
       on usplre.uid = pr.user_id and usplre.plan_ym = pr.profit_ym) as usplrepr
       full outer join 
      (select user_id, inspection_ym, 
       sum(onemonth) as onemonth, sum(sixmonth) as sixmonth, sum(years) as years, sum(years_not) as years_not,
       sum(inspection) as inspection, sum(inspection_not) as inspection_not,
       sum(insurance_new) as insurance_new, sum(insurance_renew) as insurance_renew, sum(insurance_cancel) as insurance_cancel
       from inspections group by user_id , inspection_ym) ins
       on usplrepr.uid = ins.user_id and usplrepr.plan_ym = ins.inspection_ym
       ) where usplrepr.plan_ym >= ? and usplrepr.plan_ym <= ? group by usplrepr.uid, usplrepr.user_name, usplrepr.display_order ' 
    if params[:sortkey] == 'all_sales desc' 
      strsql = strsql + 'order by all_sales desc, usplrepr.display_order, usplrepr.uid'
    elsif params[:sortkey] == 'all_profit desc'
      strsql = strsql + 'order by all_profit desc, usplrepr.display_order, usplrepr.uid'
    # 新車 受注進度
    elsif params[:sortkey] == 'progress_newcar desc'
      strsql = strsql + 'order by progress_newcar desc, usplrepr.display_order, usplrepr.uid'
    # 新車 登録進度
    elsif params[:sortkey] == 'progress_registration desc'
      strsql = strsql + 'order by progress_registration desc, usplrepr.display_order, usplrepr.uid'
    # 中古車 受注進度
    elsif params[:sortkey] == 'progress_usedcar desc'
      strsql = strsql + 'order by progress_usedcar desc, usplrepr.display_order, usplrepr.uid'
    # 12点検・24点検 実施率
    elsif params[:sortkey] == 'progress_years desc'
      strsql = strsql + 'order by progress_years desc, usplrepr.display_order, usplrepr.uid'
    # 車検 実施率
    elsif params[:sortkey] == 'progress_inspection desc'
      strsql = strsql + 'order by progress_inspection desc, usplrepr.display_order, usplrepr.uid'
    # 任意保険 実施率
    elsif params[:sortkey] == 'progress_insurance_renew desc'
      strsql = strsql + 'order by progress_insurance_renew desc, usplrepr.display_order, usplrepr.uid'
    # 新車 利益率
    elsif params[:sortkey] == 'per_profit_of_newcar desc'
      strsql = strsql + 'order by per_profit_of_newcar desc, usplrepr.display_order, usplrepr.uid'
    # 中古車 利益率
    elsif params[:sortkey] == 'per_profit_of_usedcar desc'
      strsql = strsql + 'order by per_profit_of_usedcar desc, usplrepr.display_order, usplrepr.uid'
    # サービス 利益率
    elsif params[:sortkey] == 'per_profit_of_service desc'
      strsql = strsql + 'order by per_profit_of_service desc, usplrepr.display_order, usplrepr.uid'
    # 総粗利 利益率
    elsif params[:sortkey] == 'per_all_profit desc'
      strsql = strsql + 'order by per_all_profit desc, usplrepr.display_order, usplrepr.uid'
    else
      strsql = strsql + 'order by usplrepr.display_order, usplrepr.uid'
    end
    @sales = Plan.find_by_sql([strsql, param_ym_from, param_ym_to])

    # 粗利の最終更新日
    @profit_update_date = Profit.where('profit_ym >= ? and profit_ym <= ?' ,param_ym_from, param_ym_to).maximum(:updated_at) 

   end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params[:sale]
    end

end
