class PagesController < ApplicationController
  def index
    if user_signed_in? then
      redirect_to list_path(List.last)
    end
  end
end
