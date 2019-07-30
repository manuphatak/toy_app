# frozen_string_literal: true

# Validate active storage content type
# http://www.carlosramireziii.com/validating-the-content-type-of-active-storage-attachments.html
# https://gist.github.com/carlosramireziii/6d0ca6b414d8a6af08371c30ba4dedcd#file-content_type_validator-rb
class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?
    return if value.content_type.in?(content_types)

    value.purge if record.new_record?
    record.errors.add(attribute, :content_type, options)
  end

  def content_types
    options.fetch(:in)
  end
end
