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

  # TODO : 各ユーザがもつ勤務パターンを取得できるようにする(複数ユーザ対応)
  def work_time_pattern_select
    option_label =
      proc do |record|
        "#{record.name} :  #{record.work_started_at.strftime('%H:%M')} - #{record.work_ended_at.strftime('%H:%M')}"
      end

    content_tag(
      :select,
      raw(
        WorkTimePattern.all.inject('') do |x, r|
          x + content_tag(:option, option_label.call(r), value: r.id)
        end
      ),
      name: 'time_record[work_time_pattern_id]',
      id: 'time_record_work_time_pattern_id',
      class: 'work-patterns'
    )
  end
end
