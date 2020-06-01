module Mobility
  module ActiveRecord
    # @abstract Subclass and set +table_name+ to implement for a particular column type.
    class Translation < ::ActiveRecord::Base
      self.abstract_class = true

      belongs_to :record, polymorphic: true, touch: true

      validates :name, presence: true, uniqueness: { scope: [:record_id, :record_type, :locale], case_sensitive: true }
      validates :record, presence: true
      validates :locale, presence: true
    end
  end
end
