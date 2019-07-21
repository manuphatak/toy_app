# frozen_string_literal: true

class ByteSizeValidator < ActiveModel::EachValidator
  include ActiveSupport::NumberHelper
  def validate_each(record, attribute, value)
    return unless value.attached?
    return if value.blob.byte_size < options[:maximum]

    record.errors.add(attribute, :byte_size, limit: number_to_human_size(options[:maximum]))
  end
end
