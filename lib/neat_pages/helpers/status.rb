#*************************************************************************************
# Status take care of generating the html code that show the results position and the
# total results.
#
# Output Example
#
# 30 to 40 / 300
#*************************************************************************************
class NeatPages::Helpers::Status < NeatPages::Helpers::Builder
  delegate :empty?,         to: :pagination
  delegate :offset,         to: :pagination
  delegate :out_of_bound?,  to: :pagination

  def generate
    return '' if empty? or out_of_bound?

    from, to = get_from_to_data

    return build_status from, to
  end

  private

  def build_status(from, to)
    reset_builder

    b '<span data-neat-pages-control="status" id="neat-pages-status">'
    b "<span class=\"from\">#{from+1}</span>"
    b " #{t('to')} "
    b "<span class=\"to\">#{to}</span>/"
    b "<span class=\"total\">#{total_items}</span>"
    b '</span>'

    return b
  end

  def get_from_to_data
    from = offset
    to = from + per_page
    to = total_items if to > total_items

    return [from, to]
  end
end
