module FindersByAttributeName
  class NullObject
    attr_reader :name, :value

    def initialize(name)
      @name = name
      @value = nil
    end
  end

  def with_name(name)
    name = name.to_s
    proxy_target.detect { |x| x.name == name } || NullObject.new(name)
  end
end
