module CalendarViewHelper

    def color_follow_day(today,follow_day,highlight)
        day = follow_day.day
        c = ""
        c << "this " if (highlight.class.eql?(Range) && highlight.include?(follow_day)) || follow_day == highlight
        c << "today " if follow_day == today
        c << "weekend " if [0,6].include?(follow_day.wday)
        "<td class=\"#{c}\">#{day}</td>"
    end

    def wdays_names(first_wday)
        html = ""
        first_wday.upto(first_wday+6) do |i|
            html << "<td class=\"wday\">#{t(:abbr_day_names,:scope=>:date)[i == 7 ? 0 : i]}</td>"
        end
        html
    end

    def calendar_window(options={})
        html = ""
        now = DateTime.now
        year = now.year
        month = now.month
        back = options[:back] ? options[:back] : 10
        forward = options[:forward] ? options[:forward] : 20
        highlight = options[:highlight_date] ? options[:highlight_date] : nil
        if options[:highlight_day] && options[:highlight_month] && options[:highlight_year]
            highlight = Date.new(options[:highlight_year],options[:highlight_month],options[:highlight_day])
        end
        highlight = options[:highlight_between] if options[:highlight_between]
        fday = Date.new(now.year,now.month,now.day)
        nowday = Date.new(now.year,now.month,now.day)
        fday -= back
        wdays = []
        days = []
        weeks = []
        months = []
        colspan = 1
        mcolspan = 1
        html = ""
        html << "<div class=\"calendar window\">"
        html << "<h3>#{options[:title]}</h3>" if options[:title]
        html << "<div class=\"content\">"
        html << "<table>"

        1.upto(back + forward) do
            if fday == Date.new(fday.year,fday.month,-1)
				months << "<td class=\"monthnum\" colspan=\""+mcolspan.to_s+"\">"+fday.month.to_s+"</td>"
				mcolspan=1
			else
				mcolspan+=1
			end
            if fday.wday == 0
				weeks << "<td class=\"weeknum\" colspan=\""+colspan.to_s+"\">"+fday.cweek.to_s+"</td>"
				colspan=1
			else
				colspan+=1
			end
            wdays << "<td class=\"wday\">#{t(:abbr_day_names,:scope=>:date)[fday.wday == 7 ? 0 : fday.wday]}</td>"
            days << color_follow_day(nowday,fday,highlight)
            fday = fday + 1
        end
        months << "<td class=\"monthnum\" colspan=\""+mcolspan.to_s+"\">"+fday.month.to_s+"</td>"
        weeks << "<td class=\"weeknum\" colspan=\""+colspan.to_s+"\">"+fday.cweek.to_s+"</td>"
        html << "<tr>"
        html << months.join
        html << "</tr>"
        html << "<tr>"
        html << weeks.join
        html << "</tr>"
        html << "<tr>"
        html << wdays.join
        html << "</tr>"
        html << "<tr>"
        html << days.join
        html << "</tr>"
        html << "</table></div></div>"
        html.html_safe
    end

    def calendar_square(options={})

        now = DateTime.now
        month = options[:month] ? options[:month] : now.month
        year = options[:year] ? options[:year] : now.year

        month_delta = options[:month_delta] ? options[:month_delta] : 0
        year_delta = options[:year_delta] ? options[:year_delta] : 0

        highlight = options[:highlight_date] ? options[:highlight_date] : nil
        if options[:highlight_day] && options[:highlight_month] && options[:highlight_year]
            highlight = Date.new(options[:highlight_year],options[:highlight_month],options[:highlight_day])
        end
        highlight = options[:highlight_between] if options[:highlight_between]

        month = month + month_delta
        year = year + year_delta
        delta = month.divmod(12)

        if delta[1].zero?
            year = year + delta[0] -1
            month = 12
        else
            year = year + delta[0]
            month = delta[1]
        end

        first_wday = options[:first_wday] == 0 ? 0 : 1
        last_wday = first_wday == 0 ? 6 : 0
        first = Date.new(year,month,1)
        last = Date.new(year,month,-1)
        today = Date.new(now.year,now.month,now.day)

        html = ""
        html << "<div class=\"calendar square\">"
        html << "<h3>"
        html << t(:month_names,:scope=>:date)[month]
        html << " #{year}" if year != now.year
        html << "</h3>"
        html << "<div class=\"content\">"
        html << "<table>"

        html << "<tr><td class=\"outside\">&nbsp;</td>"
        html << wdays_names(first_wday)
        html << "</tr>"

        if first.wday != first_wday
            (first_wday == 0 ? (first.wday == 0 ? 7 : first.wday) : (first.wday == 0 ? 7 : first.wday) - 1).downto(1) do |i|
                prev = first - i
                if prev.wday == first_wday
                    html << "<tr>"
                    html << "<td class=\"weeknum\">#{prev.cweek}</td>"
                end
                html << "<td class=\"outside\">#{prev.day}</td>"
            end
        end

        (first.day).upto(last.day) do |i|
            follow_day = Date.new(year,month,i)
            if follow_day.wday == first_wday
                html << "<tr>"
                html << "<td class=\"weeknum\">#{follow_day.cweek}</td>"
            end
            html << color_follow_day(today,follow_day,highlight)
            if follow_day.wday == last_wday
                html << "</tr>"
            end
        end

        if last_wday != last.wday
            1.upto(7-(first_wday == 0 ? last.wday+1 : last.wday)) do |i|
                post = last + i
                html << "<td class=\"outside\">#{post.day}</td>"
            end
        end
        html << "</tr>"

        html << "</table></div></div>"
        html.html_safe
    end

end
