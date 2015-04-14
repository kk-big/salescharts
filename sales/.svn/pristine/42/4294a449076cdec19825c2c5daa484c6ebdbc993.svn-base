class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

  # 検索フォーム
    require "date"
    d = Date.today
    default_ym = d.year.to_s + sprintf("%02d", d.month).to_s 

    if params[:plan_ym_from].nil? 
      plan_ym_from = default_ym
      @plan_ym_from = default_ym
    elsif params[:plan_ym_from].empty?
      plan_ym_from = ''
      @plan_ym_from = ''
    else
      plan_ym_from = params[:plan_ym_from]
      @plan_ym_from = params[:plan_ym_from]
    end

    if params[:plan_ym_to].nil? 
      plan_ym_to = default_ym
      @plan_ym_to = default_ym
    elsif params[:plan_ym_to].blank? 
      plan_ym_to = ''
      @plan_ym_to = ''
    else
      plan_ym_to = params[:plan_ym_to]
      @plan_ym_to = params[:plan_ym_to]
    end

    if params[:plan].blank? 
      user_id = ''
      @user_id = ''
    else
      user_id = params[:plan]
      @user_id = params[:plan][:user_id]
    end
#    @plans = Plan.search(plan_ym_from, plan_ym_to, user_id)
    @plans = Plan.joins(:user).order('users.display_order').search(plan_ym_from, plan_ym_to, user_id)
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: '計画を登録しました。' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: '計画を更新しました。' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    params.permit!
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: '計画を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:user_id, :plan_ym, :customer, :newcar, :newcar_balance, :registration_possible, :registration_plan, :usedcar, :onemonth, :sixmonth, :years, :inspection, :insurance)
    end
end
