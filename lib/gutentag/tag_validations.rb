# frozen_string_literal: true

class Gutentag::TagValidations
  DEFAULTS = {
    :presence   => true,
    :uniqueness => {:case_sensitive => false}
  }.freeze

  def self.call(klass)
    new(klass).call
  end

  def initialize(klass)
    @klass = klass
  end

  def call
    klass.validates :name, validation_options
  end

  private

  attr_reader :klass

  def add_length_validation?
    klass.table_exists? && limit.present?
  rescue StandardError
    # Catch any problem connecting to the database at this point. This will let Rails 
    # boot to run other tasks (like deploying) without being forced to have a database 
    # connection established.
    false
  end

  def limit
    @limit ||= klass.columns_hash["name"].limit
  end

  def validation_options
    return DEFAULTS unless add_length_validation?

    DEFAULTS.merge :length => {:maximum => limit}
  end
end
