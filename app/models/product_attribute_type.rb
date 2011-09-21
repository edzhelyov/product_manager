class ProductAttributeType < ActiveRecord::Base
  has_many :product_attributes, :dependent => :destroy
  set_inheritance_column :_type_ # `type` is used to hold the actual type of this attribute

  # Casts value (which is a String) to an appropriate instance.
  def type_cast(value)
    klass = ActiveRecord::ConnectionAdapters::Column

    return nil if value.nil?
    case type
    when :string    then value
    when :text      then value
    when :integer   then value.to_i rescue value ? 1 : 0
    when :float     then value.to_f
    when :decimal   then klass.value_to_decimal(value)
    when :datetime  then klass.string_to_time(value)
    when :timestamp then klass.string_to_time(value)
    when :time      then klass.string_to_dummy_time(value)
    when :date      then klass.string_to_date(value)
    when :binary    then klass.binary_to_string(value)
    when :boolean   then klass.value_to_boolean(value)
    else value
    end
  end
end
