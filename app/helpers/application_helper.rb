module ApplicationHelper
  def formatted_price(price)
    "$#{'%.2f' % (price.to_f / 100000).round(2)}"
  end


  def link_to_unless_selected(name, path, page_options = {}, html_options = {}, &block)
    if current_page?(page_options)
      html_options[:class].blank? ? html_options[:class] = "selected" : html_options[:class] += "selected"
    end
    link_to(name, path, html_options, &block)
  end
end
