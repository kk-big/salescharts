class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  # GET /inspections
  # GET /inspections.json
  def index
#    @inspections = Inspection.all

    if  session[:user_id].nil?
      redirect_to root_path and return
    end

  # 検索フォーム
    require "date"
    d = Date.today
    default_ym = d.year.to_s + sprintf("%02d", d.month).to_s 

    if params[:inspection_ym_from].nil? 
      #車点検・保険登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        inspection_ym_from = session[:cond_inspection_ym_from]
        @inspection_ym_from = session[:cond_inspection_ym_from]
      else
        inspection_ym_from = default_ym
        @inspection_ym_from = default_ym
      end
    elsif params[:inspection_ym_from].empty?
      inspection_ym_from = ''
      @inspection_ym_from = ''
    else
      inspection_ym_from = params[:inspection_ym_from]
      @inspection_ym_from = params[:inspection_ym_from]
    end

    if params[:inspection_ym_to].nil? 
      #車点検・保険登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        inspection_ym_to = session[:cond_inspection_ym_to]
        @inspection_ym_to = session[:cond_inspection_ym_to]
      else
        inspection_ym_to = default_ym
        @inspection_ym_to = default_ym
      end
    elsif params[:inspection_ym_to].empty? 
      inspection_ym_to = ''
      @inspection_ym_to = ''
    else
      inspection_ym_to = params[:inspection_ym_to]
      @inspection_ym_to = params[:inspection_ym_to]
    end

    if params[:inspection].blank? 
      #車点検・保険登録・変更から遷移した時は、セッションに保持した検索条件をセット
      if params[:param_back] == 'back'
        params[:inspection] = session[:cond_inspection_user_id]
        user_id = params[:inspection]
        #条件設定がなかった時
        if user_id.blank?
          @user_id = ''
        else
          @user_id = params[:inspection][:user_id]
        end
        params[:inspection] = ''
      else
        user_id = ''
        @user_id = ''
      end
    else
      user_id = params[:inspection]
      @user_id = params[:inspection][:user_id]
    end

    @inspections = Inspection.joins(:user).order('users.display_order').search(inspection_ym_from, inspection_ym_to, user_id)

    #検索条件をセッションに格納して保持
    session[:cond_inspection_ym_from] = inspection_ym_from
    session[:cond_inspection_ym_to] = inspection_ym_to
    session[:cond_inspection_user_id] = user_id

  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
  end

  # GET /inspections/1/edit
  def edit
  end

  # POST /inspections
  # POST /inspections.json
  def create
    @inspection = Inspection.new(inspection_params)

    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: '車点検・保険を登録しました。' }
        format.json { render :show, status: :created, location: @inspection }
      else
        format.html { render :new }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspections/1
  # PATCH/PUT /inspections/1.json
  def update
    respond_to do |format|
      if @inspection.update(inspection_params)
        format.html { redirect_to @inspection, notice: '車点検・保険を変更しました。' }
        format.json { render :show, status: :ok, location: @inspection }
      else
        format.html { render :edit }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1
  # DELETE /inspections/1.json
  def destroy
    @inspection.destroy
    respond_to do |format|
      format.html { redirect_to inspections_url, notice: '車点検・保険を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_params
      params.require(:inspection).permit(:user_id, :inspection_ym, :onemonth, :sixmonth, :years, :years_not, :inspection, :inspection_not, :insurance_new, :insurance_renew, :insurance_cancel)
    end

end
