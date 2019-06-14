# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title)
    base_title = 'Toy App'
    if page_title.present?
      page_title + ' | ' + base_title
    else
      base_title
    end
  end
end
