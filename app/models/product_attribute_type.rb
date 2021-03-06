class ProductAttributeType < ActiveRecord::Base
  has_many :product_attributes, :dependent => :destroy

  # Casts value (which is a String) to an appropriate instance.
  # This is basically a copy of the same method in AR::ConnectionAdapters::Column
  def type_cast(value)
    converter = ActiveRecord::ConnectionAdapters::Column

    return nil if value.nil?
    case data_type.to_sym
    when :string    then value
    when :text      then value
    when :integer   then value.to_i rescue value ? 1 : 0
    when :float     then value.to_f
    when :decimal   then converter.value_to_decimal(value)
    when :datetime  then converter.string_to_time(value)
    when :timestamp then converter.string_to_time(value)
    when :time      then converter.string_to_dummy_time(value)
    when :date      then converter.string_to_date(value)
    when :binary    then converter.binary_to_string(value)
    when :boolean   then converter.value_to_boolean(value)
    else value
    end
  end
end
