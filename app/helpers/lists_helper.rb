module ListsHelper
  def disable_decrease_button(included, item)
    if (!included || item.quantity == 1) then
      'disabled=\'true\''
    end
  end
end
