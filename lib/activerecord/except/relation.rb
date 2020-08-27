# frozen_string_literal: true

module ActiveRecord
  class Relation
    def except(*fields)
      inverted_fields = klass._default_attributes.keys.map(&:to_sym).reject { |attr| fields.include?(attr) }
      _select!(inverted_fields)
    end
  end
end
