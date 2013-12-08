module ApplicationHelper
  def formatted_price(price)
    "$#{price.to_f / 100000}"
  end
end
