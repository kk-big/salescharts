class ProfitsController < ApplicationController
  before_action :set_profit, only: [:show, :edit, :update, :destroy]

  # GET /profits
  # GET /profits.json
  def index
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

  # 検索フォーム
    require "date"
    d = Date.today
    default_ym = d.year.to_s + sprintf("%02d", d.month).to_s 

    if params[:profit_ym_from].nil? 
      #粗利登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        profit_ym_from = session[:cond_profit_ym_from]
        @profit_ym_from = session[:cond_profit_ym_from]
      else
        profit_ym_from = default_ym
        @profit_ym_from = default_ym
      end
    elsif params[:profit_ym_from].empty?
      profit_ym_from = ''
      @profit_ym_from = ''
    else
      profit_ym_from = params[:profit_ym_from]
      @profit_ym_from = params[:profit_ym_from]
    end

    if params[:profit_ym_to].nil? 
      #粗利登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        profit_ym_to = session[:cond_profit_ym_to]
        @profit_ym_to = session[:cond_profit_ym_to]
      else
        profit_ym_to = default_ym
        @profit_ym_to = default_ym
      end
    elsif params[:profit_ym_to].empty? 
      profit_ym_to = ''
      @profit_ym_to = ''
    else
      profit_ym_to = params[:profit_ym_to]
      @profit_ym_to = params[:profit_ym_to]
    end

    if params[:profit].blank? 
      #粗利登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        params[:profit] = session[:cond_profit_user_id]
        user_id = params[:profit]
        #条件設定がなかった時
        if user_id.blank?
          @user_id = ''
        else
          @user_id = params[:profit][:user_id]
        end
        params[:profit] = ''
      else
        user_id = ''
        @user_id = ''
      end
    else
      user_id = params[:profit]
      @user_id = params[:profit][:user_id]
    end

#    @profits = Profit.search(profit_ym_from, profit_ym_to, user_id)
    @profits = Profit.joins(:user).order('users.display_order').search(profit_ym_from, profit_ym_to, user_id)

    #検索条件をセッションに格納して保持
    session[:cond_profit_ym_from] = profit_ym_from
    session[:cond_profit_ym_to] = profit_ym_to
    session[:cond_profit_user_id] = user_id

  end

  # GET /profits/1
  # GET /profits/1.json
  def show
  end

  # GET /profits/new
  def new
    @profit = Profit.new
  end

  # GET /profits/1/edit
  def edit
  end

  # POST /profits
  # POST /profits.json
  def create
    @profit = Profit.new(profit_params)

    respond_to do |format|
      if @profit.save
        format.html { redirect_to @profit, notice: '粗利を登録しました。' }
        format.json { render :show, status: :created, location: @profit }
      else
        format.html { render :new }
        format.json { render json: @profit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profits/1
  # PATCH/PUT /profits/1.json
  def update
    respond_to do |format|
      if @profit.update(profit_params)
        format.html { redirect_to @profit, notice: '粗利を更新しました。' }
        format.json { render :show, status: :ok, location: @profit }
      else
        format.html { render :edit }
        format.json { render json: @profit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profits/1
  # DELETE /profits/1.json
  def destroy
    @profit.destroy
    respond_to do |format|
      format.html { redirect_to profits_url, notice: '粗利を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profit
      @profit = Profit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profit_params
      params.require(:profit).permit(:user_id,:profit_ym, :number_of_newcar, :sales_of_newcar, :profit_of_newcar, :sales_of_usedcar, :number_of_usedcar, :profit_of_usedcar, :number_of_service, :sales_of_service, :profit_of_service)
    end
end
