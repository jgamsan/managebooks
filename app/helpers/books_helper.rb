module BooksHelper

  def calendar_weekly(intervals)
    cal = %(<table class="table table-condensed">\n)
    cal << %(\t<thead>\n\t\t<tr>\n)
    cal << %(\t\t\t<th align='center'>)
    cal << "Horario"
    cal << %(</th>\n)
    for i in 0..6 do
      cal << %(\t\t\t<th text-align='center'>)
      cal << l(@primero + i, {:format => '%a %d'})
      cal << %(</th>\n)
    end

    cal << "\t\t</tr>\n\t</thead>\n\t<tbody>\n"
    intervals.each do |interval|
      cal << %(\t\t<tr>\n)
      cal << "\t\t\t<td>\n #{interval.init.strftime('%H:%M')} - #{interval.finish.strftime('%H:%M')} &nbsp;\t\t\t</td>\n"
      i = 0
      @semana.each do |dia|
        if dia.include?(interval.id) && ((@primero + i) >= Date.today)
          cal << td_green(interval.id, @primero + i)
        else
          cal << td_grey
        end
        i += 1
      end
      cal << %(\t\t</tr>)
    end
    cal << "\n\t</tbody>\n</table>"
    cal.html_safe
  end

  def image_green(interval, dia)
    link_to image_tag("check.gif", :size => "24x24"), get_book_path(interval, dia), :remote => true
  end

  def image_grey
    image_tag "check-grey.gif", :size => "24x24"
  end

  def td_grey
    "\t\t\t<td align='center'>\n" + image_grey + "&nbsp;\t\t\t</td>\n"
  end

  def td_green(interval, dia)
    "\t\t\t<td align='center'>\n" + image_green(interval, dia) + "&nbsp;\t\t\t</td>\n"
  end
  
end

