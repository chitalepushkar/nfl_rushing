module SharedMethods
  extend ActiveSupport::Concern

  class_methods do
    def bulk_alias_attribute **attribute_hash
      if attribute_hash.present?
        attribute_hash.each do |new_name, old_name|
          alias_attribute new_name, old_name
        end
      end
    end
  end
end
