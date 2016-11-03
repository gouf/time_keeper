module TimeRecordsHelper
  def year_month_display
    # 矢印リンク付きの年月を表示
    # ←年→←月→
    content_tag(
      :h2,
      content_tag(
        :a,
        '←',
        href: "#{time_records_path}?year=#{@year - 1}&month=#{@month}"
      ) +
      content_tag(:span, "#{@year}年") +
      content_tag(
        :a,
        '→',
        href: "#{time_records_path}?year=#{@year + 1}&month=#{@month}"
      ) +
      content_tag(
        :a,
        '←',
        href: "#{time_records_path}?year=#{@year}&month=#{@month - 1}"
      ) +
      content_tag(:span, "#{@month}月") +
      content_tag(
        :a,
        '→',
        href: "#{time_records_path}?year=#{@year}&month=#{@month + 1}"
      ),
      class: 'text-center'
    )
  end

  def worked_time(work_time)
    hour = work_time.map { |x| x.dig(:work_time, :hour).to_i }.inject(:+)
    min = work_time.map { |x| x.dig(:work_time, :min).to_i }.inject(:+)

    # 分が持ちすぎている値を時に繰り上げ
    add_to_hour, min = min.divmod(60)
    hour += add_to_hour

    "#{hour}:#{min}"
  end
end
