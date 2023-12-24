# frozen_string_literal: true

require 'i18n'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.implicit_order_column = 'created_at'

  def as_dto
    safe_attributes = attributes.keys.reject do |attribute|
      %w[otp password token salt].any? { |word| attribute.include?(word) }
    end
    attributes.slice(*safe_attributes)
  end
end
