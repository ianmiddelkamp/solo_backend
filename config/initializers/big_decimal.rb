BigDecimal.class_eval do
  def as_json(_options = nil)
    to_f
  end
end
