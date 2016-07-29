class ApiParameterException < Exception
  attr_accessor :errors

  def initialize
    @errors = {}
  end

  def has_errors?
    @errors.any?
  end

  def add_error(field, message)
    @errors[field] ||= []
    @errors[field] << message
    self
  end

  def add_missing(field)
    add_error field, "can't be blank"
  end

  def add_existing(field)
    add_error field, "must be blank"
  end

  def add_wrong(field)
    add_error field, "wrong value"
  end

  def add_length(field)
    add_error field, "is the wrong length"
  end
end
