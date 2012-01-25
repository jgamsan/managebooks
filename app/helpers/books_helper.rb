module BooksHelper

  def calendar_weekly(intervals)
    cal = %(<table>\n)
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
      unless (@lunes.include?(interval.id) && (@primero > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@martes.include?(interval.id)  && ((@primero + 1) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero + 1), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@miercoles.include?(interval.id)  && ((@primero + 2) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero + 2), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@jueves.include?(interval.id)  && ((@primero + 3) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero + 3), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@viernes.include?(interval.id)  && ((@primero + 4) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero + 4), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@sabado.include?(interval.id)  && ((@primero + 5) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero + 5), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      unless (@domingo.include?(interval.id)  && ((@primero + 6) > Date.today))
        cal << "\t\t\t<td align='center'>\n" + image_tag("check_grey_alt_24x24.png") + "&nbsp;\t\t\t</td>\n"
      else
        cal << "\t\t\t<td align='center'>\n" + link_to(image_tag("check_green_alt_24x24.png"), get_book_path(interval.id, @primero  + 6), :remote => true) + "&nbsp;\t\t\t</td>\n"
      end
      cal << %(\t\t</tr>)
    end
    cal << "\n\t</tbody>\n</table>"
    cal.html_safe
  end
end

