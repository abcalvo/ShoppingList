class PagesController < ApplicationController
  def index
    if user_signed_in? then
      if current_user.lists.count > 0 then
        redirect_to list_path(current_user.lists.order('marked_as_default_at DESC').first)
      else
        redirect_to new_list_path
      end
    end
  end
end
