module Gutentag::HasManyTags
  extend ActiveSupport::Concern

  module ClassMethods
    def has_many_tags
      Rails.logger.warn <<-TXT
has_many_tags is now deprecated, and will be removed in Gutentag v1.0.0.
Replace it with Gutentag::ActiveRecord.call(self), and everything will continue
to work as expected.
      TXT
      Gutentag::ActiveRecord.call self
    end
  end
end
