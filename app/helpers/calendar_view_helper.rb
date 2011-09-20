module CalendarViewHelper
    def calendar_cube(options={})
        now = DateTime.now
        first = Date.new(now.year,now.month,1)
        last = Date.new(now.year,now.month,-1)
        curr_week = first.cweek
        html = "<h3>"
        html << t(:month_names,:scope=>:date)[now.month]
        html << "</h3><div class=\"content\">"
        html << "<table class=\"side_calendar width100\">"

        html << "<tr><td></td>"
        1.upto(6) do |i|
            html << "<td class=\"wday\">#{t(:abbr_day_names,:scope=>:date)[i]}</td>"
        end
        html << "<td class=\"wday\">#{t(:abbr_day_names,:scope=>:date)[0]}</td>"
        html << "</tr>"


        html << "<tr>"
        html << "<td class=\"week\">#{first.cweek}</td>"

        (first.wday-1).downto(1) do |i|
            prev = first - i
            html << "<td class=\"off\">#{prev.day}</td>"
        end

        (first.day).upto(last.day) do |i|
            curr = Date.new(now.year,now.month,i)
            if curr.wday == 1
                html << "</tr>"
                html << "<tr>"
                curr_week += 1
                html << "<td class=\"week\">#{curr_week}</td>"
            end
            if now.day == i
                html << "<td class=\"today\">#{i}</td>"
            else
                if curr.wday == 0 || curr.wday == 6
                    html << "<td class=\"weekend\">#{i}</td>"
                else
                    html << "<td>#{i}</td>"
                end
            end
        end

        1.upto(7-last.wday) do |i|
            post = last + i
            html << "<td class=\"off\">#{post.day}</td>"
        end

        html << "</tr>"
        html << "</table></div>"
        html
    end
end
