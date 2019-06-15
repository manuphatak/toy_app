# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, klass: 'gravatar', default: 'robohash', size: 80, rating: 'g')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    query = { s: size, d: default, r: rating }.to_query
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?#{query}"
    image_tag(gravatar_url, alt: user.name, class: klass)
  end
end
