require 'spec_helper'

describe ProductManager do
  it "is valid" do
    ProductManager.should be_a(Module)
  end

  it "load Product model" do
    ActiveRecord::Base.descendants.include?(Product).should be_true
  end
end
