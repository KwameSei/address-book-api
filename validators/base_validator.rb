class BaseValidator
  attr_reader :errors, :data

  def initialize(data)
    @data = data
    @errors = []
    validate
  end

  def valid?
    @errors.empty?
  end

  protected

  # Required field
  def require(field)
    value = data[field]
    add_error("#{field} is required") if value.nil? || value.strip.empty?
  end

  # Minimum length
  def min_length(field, length)
    empty_value_return(field)
    value = data[field]

    add_error("#{field} must be at least #{length} characters long") if value && value.strip.length < length
  end

  # Max length
  def max_length(field, length)
    empty_value_return(field)
    value = data[field]

    add_error("#{field} must be at most #{length} characters long") if value && value.strip.length > length
  end

  # Correct email format
  def email_format(field)
    empty_value_return(field)
    value = data[field]

    unless value.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
      add_error("#{field} is not a valid email")
    end
  end

  # Only digits field
  def numeric_only(field)
    empty_value_return(field)
    value = data[field]

    unless value.match?(/\A\d+\z/)
      add_error("#{field} must contain only digits")
    end
  end

  # Validates a basic phone number (10 digits)
  def valid_phone(field)
    empty_value_return(field)
    value = data[field]

    unless value.match?(/\A\d{10}\z/)
      add_error("#{field} must be a valid 10-digit phone number")
    end
  end

  # Validates Ghanaian mobile numbers (local or international format)
  def valid_ghana_phone(field)
    empty_value_return(field)
    value = data[field]

    ghana_local_pattern = /\A(02|05|03)\d{8}\z/
    ghana_intnl_pattern = /\A(\+233|233)(2|5|3)\d{8}\z/

    unless value.match?(ghana_local_pattern) || value.match?(ghana_intnl_pattern)
      add_error("#{field} must be a valid Ghana phone number")
    end
  end

  # Normalize Ghana phone numbers to local format
  def normalize_phone_num_to_local(field)
    empty_value_return(field)
    value = data[field]

    normalized = if value.start_with?('+233')
      '0' + value[4..]
    elsif value.start_with?('233')
      '0' + value[3..]
    else
      value
    end

    data[field] = normalized
  end

  # Checks for only numbers and letters
  def alphanumeric(field)
    empty_value_return(field)
    value = data[field]

    unless value.match?(/\A[a-zA-Z0-9]+\z/)
      add_error("#{field} must be alphanumeric")
    end
  end

  # Enforces value between a range (e.g., for age or rating)
  def between_range(field, min, max)
    value = data[field]
    return if value.nil? || value.strip.empty?

    number = value.to_i
    unless number >= min && number <= max
      add_error(field, "must be between #{min} and #{max}")
    end
  end

  # Match with another field (e.g. password confirmation)
  def matches(field, other_field)
    value = data[field]
    other_value = data[other_field]
    if value != other_value
      add_error("#{field} must match #{other_field}")
    end
  end

   # DB-based uniqueness checks
  # def unique(field, model_class)
  #   if model_class.where(field => data[field]).exists?
  #     add_error(field, 'has already been taken')
  #   end
  # end

  private

  def add_error(message)
    @errors << message
  end

  def empty_value_return(field)
    value = data[field]
    return if value.nil? || value.strip.empty?
  end
end
