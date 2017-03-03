class OpenHourSort
  def initialize(open_hours)
    @open_hours = open_hours
  end

  def call
    def_hrs = ["12h - 12h30", "15h - 15h30", "16h - 16h30", "17h - 17h30", "18h - 18h30"]
    my_day = Date.today
    date_now = @open_hours.find_by(day: my_day.wday.to_s)
    ### 1 = Mon, ... 6 = Sat, 0 = Sun !!!!!!!
    if date_now.nil?    # wday == 0
      my_day = Date.tomorrow
      date_now = @open_hours.find_by(day: my_day.wday.to_s)
    end
    arr_retu = build_table(date_now.open_time, date_now.closed_time) unless date_now.nil?
    return arr_retu.nil? ? def_hrs : arr_retu
  end

  def build_table(t_open, t_closed)
    hours = []
    mins = t_open.min == 0 ? "00" : t_open.min.to_s
    for i in (t_open.hour + 1)..(t_closed.hour + 1)
      if mins == "00"
        hours << "#{i}:#{mins} - #{i}:30" unless i == 13
        hours << "#{i}:30 - #{i+1}:00" unless i == 13
      else
        hours << "#{i}:#{mins} - #{i+1}:00" unless i == 13
        mins = "00"
      end
    end
    hours
  end
end
