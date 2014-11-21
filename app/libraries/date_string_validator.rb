class DateStringValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      Date.parse(value)
    rescue ArgumentError
      record.errors[attribute] << :invalid
    end
  end
end
