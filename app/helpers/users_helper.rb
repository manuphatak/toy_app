# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, options = {})
    options = { class: 'gravatar', default: 'robohash', size: 80, rating: 'g' }.merge(options)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    query = { s: options[:size], d: options[:default], r: options[:rating] }.to_query
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?#{query}"
    image_tag(gravatar_url, alt: user.name, class: options[:class])
  end
end
