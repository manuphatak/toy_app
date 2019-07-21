# frozen_string_literal: true

RSpec::Matchers.define :accept_content_types do |*content_types|
  match do |record|
    matcher.matches?(record, content_types)
  end

  chain :for do |attr_name|
    matcher.for(attr_name)
  end

  failure_message do |_actual|
    content_types = pluralize_without_count(matcher.fails.length, 'content type')
    "expected #{formatted_actual} to accept #{content_types} #{formatted_expected}"
  end

  private

  def matcher
    @matcher ||= AcceptContentTypes.new
  end

  def formatted_actual
    "#{actual.class.name}##{matcher.attr_name}"
  end

  def formatted_expected
    matcher.fails.map(&:inspect).join(', ')
  end

  def pluralize_without_count(count, noun)
    count == 1 ? noun : noun.pluralize
  end

  class AcceptContentTypes
    attr_reader :attr_name
    def for(attr_name)
      @attr_name = attr_name
    end

    def matches?(record, content_types)
      @record = record
      @content_types = Array.wrap(content_types)

      fails.blank?
    end

    def fails
      @fails ||= content_types.filter do |content_type|
        record.send(attr_name).attach attachment_for(content_type)
        record.valid?
        record.errors[attr_name].include?(message)
      end
    end

    private

    attr_reader :record, :content_types

    def attachment_for(content_type)
      { io: StringIO.new('Fake File'), filename: 'temp', content_type: content_type }
    end

    def message
      I18n.t('errors.messages.content_type')
    end
  end
end

RSpec::Matchers.alias_matcher :allow_content_type, :accept_content_types
