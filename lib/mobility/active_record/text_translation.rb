# frozen_string_literal: true
require "mobility/active_record/translation"

module Mobility
  module ActiveRecord
    class TextTranslation < Translation
      self.table_name = "action_text_rich_texts"
    end
  end
end
