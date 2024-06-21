module CalendarHelper
  def calendar_selected_day_target(day, selected_day)
    if day == selected_day
      "selectedDay"
    elsif day == Date.current
      "currentDay"
    else
      ""
    end
  end
end
