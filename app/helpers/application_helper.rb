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

  def nav_item(text, path, **kwargs)
    current_class = current_page?(path) ? 'active' : nil
    current_text = current_page?(path) ? content_tag(:span, '(current)', class: 'sr-only') : ''

    content_tag(:li, class: ['nav-item', current_class, kwargs.delete(:class)], **kwargs) do
      link_to(path, class: 'nav-link') do
        content_tag(:span, text) + current_text
      end
    end
  end

  def nav_dropdown_item(text, path, **kwargs)
    current_class = current_page?(path) ? 'active' : nil
    current_text = current_page?(path) ? content_tag(:span, '(current)', class: 'sr-only') : ''

    link_to(path, class: ['dropdown-item', current_class, kwargs.delete(:class)], **kwargs) do
      content_tag(:span, text) + current_text
    end
  end
end
