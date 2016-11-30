class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_year_month_instance_variable, only: [:index]

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_year_month_instance_variable
    # params[:year], params[:month] 情報から年月の表示を移動する
    # 次点 session[:year], session[:month] から取り出し
    # なければ現在の年・月から値を設定
    @year, @month =
      [
        params[:year].nil? ? nil : params[:year].to_i,
        params[:month].nil? ? nil : params[:month].to_i
      ]

    @year ||= session[:year]
    @month ||= session[:month]

    @year ||= Date.today.year
    @month ||= Date.today.month

    # 月がその範囲を踏み切ったときに年を移動する
    @month, @year = [12, @year - 1] if @month < 1
    @month, @year = [1, @year + 1] if @month > 12

    # 値をセッションに保存して再利用する
    # レコード 編集後のページ遷移に対応する
    session[:year] = @year
    session[:month] = @month
  end
end
