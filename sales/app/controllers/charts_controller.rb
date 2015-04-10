class ChartsController < ApplicationController
  before_action :set_chart, only: [:show, :edit, :update, :destroy]
  before_action :check_chart, only: [:create]

  # GET /charts
  # GET /charts.json
  def index
#    render "create"
  end

  # GET /charts/1
  # GET /charts/1.json
  def show
  end

  # GET /charts/new
  def new
    @chart = Chart.new
  end

  # GET /charts/1/edit
  def edit
  end

  # POST /charts
  # POST /charts.json
  def create
    if  session[:user_id].nil?
      redirect_to root_path and return
    end

    xaxis_all = params[:xaxis].split(",")

   # 棒グラフ
    if params[:chart_cat] == 'bar'

      check_on = params[:check_on].keys
      check_no = Array.new()
      check_on.each do |check|
        check_no.push(check.gsub('no','').to_i)
      end  

      case params[:radios_bar]
 
      # 商談・査定・試乗
      when 'chart_3s' then
        fseries1_all = params[:fseries1].split(",")
        fseries2_all = params[:fseries2].split(",")
        fseries3_all = params[:fseries3].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "商談・査定・試乗 件数")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "商談", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :dataLabels => {enabled:true})
          f.series(:name => "査定", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :dataLabels => {enabled:true})
          f.series(:name => "試乗", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :dataLabels => {enabled:true})    
          f.yAxis [
            {:title => {:text => "件数", :margin => 5} },
          ]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:defaultSeriesType=>"column", :height => 560)
        end
      # 新車車 受注・登録台数／計画進度
      when 'chart_newcar' then
        fseries1_all = params[:fseries_pl_newcar].split(",")
        fseries2_all = params[:fseries_newcar].split(",")
        fseries3_all = params[:fseries_percentage_newcar].split(",")
        fseries4_all = params[:fseries_registration].split(",")
        fseries5_all = params[:fseries_percentage_registration].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        fseries4 = Array.new()
        fseries5 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
          fseries4.push(fseries4_all[no])
          fseries5.push(fseries5_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "新車 受注・登録台数、計画進度")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "計画", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "受注", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "登録", :yAxis => 0, :data => fseries4.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "受注進度", :yAxis => 1, :data => fseries3.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.series(:name => "登録進度", :yAxis => 1, :data => fseries5.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '台数' }}, { title: { text: '進度％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 中古車 受注・登録台数／計画進度
      when 'chart_usedcar' then
        fseries1_all = params[:fseries_pl_usedcar].split(",")
        fseries2_all = params[:fseries_usedcar].split(",")
        fseries3_all = params[:fseries_percentage_usedcar].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "中古車 受注登録台数、受注進度")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "計画", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "受注", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "受注進度", :yAxis => 1, :data => fseries3.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '台数' }}, { title: { text: '進度％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【初回1ヶ月点検】実施台数
      when 'chart_onemonth' then
        fseries1_all = params[:fseries_pl_onemonth].split(",")
        fseries2_all = params[:fseries_onemonth].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "初回1ヶ月点検 実施台数")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "対象", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true})
          f.series(:name => "実施", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true})
          f.yAxis [
            {:title => {:text => "台数", :margin => 5} },
          ]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:defaultSeriesType=>"column", :height => 560)
        end
      # 【初回6ヶ月点検】実施台数
      when 'chart_sixmonth' then
        fseries1_all = params[:fseries_pl_sixmonth].split(",")
        fseries2_all = params[:fseries_sixmonth].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "初回6ヶ月点検 実施台数")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "対象", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true})
          f.series(:name => "実施", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true})
          f.yAxis [
            {:title => {:text => "台数", :margin => 5} },
          ]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:defaultSeriesType=>"column", :height => 560)
        end
      # 【12ヶ月・24ヶ月点検】実施台数／実施率
      when 'chart_years' then
        fseries1_all = params[:fseries_pl_years].split(",")
        fseries2_all = params[:fseries_years].split(",")
        fseries3_all = params[:fseries_years_not].split(",")
        fseries4_all = params[:fseries_percentage_all_years].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        fseries4 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
          fseries4.push(fseries4_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "12ヶ月・24ヶ月点検 実施台数、実施率")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "対象", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "実施", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "対象外実施", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "実施率", :yAxis => 1, :data => fseries4.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '台数' }}, { title: { text: '実施率％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【車検】実施台数／実施率
      when 'chart_inspection' then
        fseries1_all = params[:fseries_pl_inspection].split(",")
        fseries2_all = params[:fseries_inspection].split(",")
        fseries3_all = params[:fseries_inspection_not].split(",")
        fseries4_all = params[:fseries_percentage_all_inspection].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        fseries4 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
          fseries4.push(fseries4_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "【車検】実施台数、実施率")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "対象", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "実施", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "対象外実施", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "実施率", :yAxis => 1, :data => fseries4.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '台数' }}, { title: { text: '実施率％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【任意保険】件数／継続率
      when 'chart_insurance' then
        fseries1_all = params[:fseries_insurance_new].split(",")
        fseries2_all = params[:fseries_pl_insurance].split(",")
        fseries3_all = params[:fseries_insurance_renew].split(",")
        fseries4_all = params[:fseries_percentage_insurance_renew].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        fseries4 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
          fseries4.push(fseries4_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "任意保険 件数、継続率")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "新規", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "継続対象", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "継続", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "継続率", :yAxis => 1, :data => fseries4.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '件数' }}, { title: { text: '継続率％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【新車】台数、売上額・粗利
      when 'chart_profit_of_newcar' then
        fseries1_all = params[:fseries_number_of_newcar].split(",")
        fseries2_all = params[:fseries_profit_of_newcar].split(",")
        fseries3_all = params[:fseries_sales_of_newcar].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "新車 売上台数、売上額・粗利額")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "売上額", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "粗利額", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "台数", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "line", :yAxis => 1)
          f.options[:yAxis] = [{ title: { text: '金額' }}, { title: { text: '台数'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【中古車】台数／粗利
      when 'chart_profit_of_usedcar' then
        fseries1_all = params[:fseries_number_of_usedcar].split(",")
        fseries2_all = params[:fseries_profit_of_usedcar].split(",")
        fseries3_all = params[:fseries_sales_of_usedcar].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "中古車 売上台数、売上額・粗利額")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "売上額", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "粗利額", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "台数", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "line", :yAxis => 1)
          f.options[:yAxis] = [{ title: { text: '金額' }}, { title: { text: '台数'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【サービス】台数／粗利
      when 'chart_profit_of_service' then
        fseries1_all = params[:fseries_number_of_service].split(",")
        fseries2_all = params[:fseries_profit_of_service].split(",")
        fseries3_all = params[:fseries_sales_of_service].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "サービス 入庫台数、売上額・粗利額")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "売上額", :yAxis => 0, :data => fseries3.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "粗利額", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "台数", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "line", :yAxis => 1)
          f.options[:yAxis] = [{ title: { text: '金額' }}, { title: { text: '台数'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      # 【総粗利】金額
      when 'chart_profit_of_all' then
        fseries1_all = params[:fseries_profit_of_all].split(",")
        fseries2_all = params[:fseries_sales_of_all].split(",")
        fseries3_all = params[:fseries_percentage_profit_of_all].split(",")
        xaxis = Array.new()
        fseries1 = Array.new()
        fseries2 = Array.new()
        fseries3 = Array.new()
        check_no.each do |no|
          xaxis.push(xaxis_all[no])
          fseries1.push(fseries1_all[no])
          fseries2.push(fseries2_all[no])
          fseries3.push(fseries3_all[no])
        end
        @chart = LazyHighCharts::HighChart.new("graph") do |f|
          f.title(:text => "総売上額・粗利額、総利益率")
          f.subtitle(text: params[:subtitle])
          f.xAxis(:categories => xaxis)
          f.series(:name => "売上額", :yAxis => 0, :data => fseries2.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "粗利額", :yAxis => 0, :data => fseries1.map(&:to_i), :dataLabels => {enabled:true}, :type => "column")
          f.series(:name => "利益率", :yAxis => 1, :data => fseries3.map(&:to_f), :dataLabels => {enabled:true}, :type => "line")
          f.options[:yAxis] = [{ title: { text: '金額（千円）' }}, { title: { text: '利益率％'}, opposite: true}]
          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart(:height => '560')
        end
      else
        logger.debug("else")
      end
    end

  # 折れ線グラフ
    if params[:chart_cat] == 'line'

      categories_all = params[:categories].split(",")
      categories = Array.new()
      i = 0
      categories_all.each do |cat|
        categories.push(categories_all[i])
        i += 1
      end

      case params[:radios_line]
      # 【顧客】契約台数推移
      when 'customer' then
      # 対象データ存在チェック
        if params[:check_on_customer].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_customer].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_customer_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '管理内台数')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_i), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "台数", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【新車】受注計画進度推移
      when 'percentage_newcar' then
      # 対象データ存在チェック
        if params[:check_on_percentage_newcar].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_newcar].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_newcar_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '新車 受注進度')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "受注進度％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【新車】登録計画進度推移
      when 'percentage_registration' then
      # 対象データ存在チェック
        if params[:check_on_percentage_registration].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_registration].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_registration_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '新車 登録進度')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "登録進度％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【中古車】計画進度推移
      when 'percentage_usedcar' then
      # 対象データ存在チェック
        if params[:check_on_percentage_usedcar].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_usedcar].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_usedcar_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '中古車 受注進度')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "受注進度％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【12点検・24点検】実施率推移
      when 'percentage_years' then
      # 対象データ存在チェック
        if params[:check_on_percentage_years].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_years].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_years_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '12点検・24点検 実施率')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "実施率％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【車検】実施率推移
      when 'percentage_inspection' then
      # 対象データ存在チェック
        if params[:check_on_percentage_inspection].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_inspection].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_inspection_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '車検 実施率')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "実施率％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      # 【任意保険】継続率推移
      when 'percentage_insurance_renew' then
      # 対象データ存在チェック
        if params[:check_on_percentage_insurance_renew].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end

        check_on = params[:check_on_percentage_insurance_renew].keys
        check_no = Array.new()
        check_on.each do |check|
          check_no.push(check.gsub('no','').to_i)
        end  
        data_all = params[:fseries_percentage_insurance_renew_all].split("#")
        data = Array.new()
        xaxis = Array.new()
        check_no.each do |no|
          data.push(data_all[no].split(","))
          xaxis.push(xaxis_all[no])
        end
        @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '任意保険 継続率')
        f.subtitle(text: params[:subtitle])
        f.xAxis(:categories => categories)
        num = 0
        while num < xaxis.length do
          f.series(:name => xaxis[num],  :data => data[num].map(&:to_f), :dataLabels => {enabled:true})
          num += 1
        end
        f.yAxis [{:title => {:text => "継続率％", :margin => 5} },]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart(:height => '560')
        end

      else
        logger.debug("else")
      end
    end

  end

  # PATCH/PUT /charts/1
  # PATCH/PUT /charts/1.json
  def update
    respond_to do |format|
      if @chart.update(chart_params)
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @chart }
      else
        format.html { render :edit }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.json
  def destroy
    @chart.destroy
    respond_to do |format|
      format.html { redirect_to charts_url, notice: 'Chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chart_params
      params[:chart]
    end

    # 対象データ存在チェック
    def check_chart
      if params[:chart_cat] == 'bar'
        if params[:check_on].nil? 
          redirect_to charts_path, :notice => "1件以上データを選択してください。"
          return
        end
      end
    end
end
