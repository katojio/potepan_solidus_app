module ApplicationHelper
  # return full title of each page
  def full_title(page_title = '')
    base_title = 'BIGBAG Store'
    if page_title.blank?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
end
