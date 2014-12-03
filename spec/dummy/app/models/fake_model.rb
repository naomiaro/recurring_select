class FakeModel
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recurring_rules

  def current_existing_rule
    IceCube::Rule.monthly.day_of_month(-1)
  end

  def persisted?; false; end
end
