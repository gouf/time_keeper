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
    # 勤務時間を時・分に分けて合算
    hour = work_time.map { |x| x.dig(:work_time, :hour).to_i }.inject(:+)
    min = work_time.map { |x| x.dig(:work_time, :min).to_i }.inject(:+)

    # 分が持ちすぎている値を時に繰り上げ
    add_to_hour, min = min.divmod(60)
    hour += add_to_hour

    "#{hour}:#{min}"
  end

  # TODO : 各ユーザがもつ勤務パターンを取得できるようにする(複数ユーザ対応)
  def work_time_pattern_select
    # 勤務パターン未登録時に、登録を促すメッセージを表示
    empty_set =
      proc do
        content_tag(:select,
          content_tag(:option, '※勤務パターンを登録してください'),
          id: 'time_record_work_time_pattern_id',
          class: 'work-patterns'
        )
      end
    return empty_set.call if WorkTimePattern.all.size.zero?

    # 勤務パターンを開始終了時刻を含めて表示
    # eg. パターン1 : hh:mm - hh:mm
    option_label =
      proc do |record|
        "#{record.name} :  #{record.work_started_at.strftime('%H:%M')} - #{record.work_ended_at.strftime('%H:%M')}"
      end

    # WorkTimePattern から得たレコードを<option/> として生成
    work_time_patterns_in_option =
      proc do
        work_time_patterns =
          WorkTimePattern.all.inject('') do |result, record|
            result + content_tag(:option, option_label.call(record), value: record.id)
          end
      end

    # <select/> で使う<options/> の生成
    options =
      content_tag(:option, '選択してください') +
      raw(work_time_patterns_in_option.call)

    content_tag(
      :select,
      options,
      name: 'time_record[work_time_pattern_id]',
      id: 'time_record_work_time_pattern_id',
      class: 'work-patterns'
    )
  end
end
