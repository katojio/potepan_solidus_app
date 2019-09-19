# frozen_string_literal: true

# application_helper
module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(page_title="")
    base_title = "BIGBAG Store"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
  
end
