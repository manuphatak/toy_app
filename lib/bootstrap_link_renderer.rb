# frozen_string_literal: true

class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
  include ActionView::Helpers::TagHelper
  def page_number(page)
    if page == current_page
      text = page.to_s.html_safe + content_tag(:span, '(current)', class: 'sr-only')
      page_item(content_tag(:span, text, class: 'page-link'), class: 'active', aria: { current: 'page' })
    else
      page_item(link(page, page, rel: rel_value(page), class: 'page-link'))
    end
  end

  def gap
    text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    page_item(content_tag(:span, text.html_safe, class: 'page-link'), class: 'disabled')
  end

  def previous_or_next_page(page, text, classname)
    if page
      page_item(link(text, page, class: "page-link #{classname}"))
    else
      page_item(content_tag(:span, text.html_safe, class: "page-link #{classname}"), class: 'disabled')
    end
  end

  def html_container(html)
    content_tag(:ul, html.html_safe, container_attributes)
  end

  private

  def link(text, target, attributes = {})
    if target.is_a? Integer
      attributes[:rel] = rel_value(target)
      target = url(target)
    end
    attributes[:href] = target
    content_tag(:a, text.to_s.html_safe, attributes)
  end

  def page_item(content, attributes = {})
    content_tag(:li, content.html_safe, class: ['page-item', attributes.delete(:class)].compact.join(' '), **attributes)
  end
end
