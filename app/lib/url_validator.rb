require 'active_model'

class UrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI::DEFAULT_PARSER.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, :invalid_url)
    end
  end
end
